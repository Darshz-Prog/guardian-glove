// === Libraries ===
#include <TinyGPSPlus.h>
#include <Wire.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>

// === Firebase objects ===
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// === CONFIG - update these ===
// WiFi credentials
const char* WIFI_SSID = "WIFI-NAMW";
const char* WIFI_PASS = "WIFI_PASS";

// Firebase
#define DATABASE_URL "https://mapcords-8c556-default-rtdb.firebaseio.com/"
#define API_KEY "API-KEY"
const char* FIREBASE_DATABASE_SECRET = "YOUR_DATABASE_SECRET";

const double FALLBACK_LAT = 23.187001;   
const double FALLBACK_LON =  72.627983;

const char* DEVICE_PATH = "PATH-HERE";

// === Pins ===
#define GPS_RX_PIN 16   // GPS TX -> ESP32 RX2
#define GPS_TX_PIN 17   // GPS RX -> ESP32 TX2
#define GPS_BAUD 9600

const int TRIG_PIN = 5;
const int ECHO_PIN = 18;
const int MOTOR_PIN = 33;   // drive via transistor/MOSFET, not directly

// === Timing ===
const unsigned long gpsDisplayIntervalMs = 60UL * 1000UL; // 1 minute between GPS uploads
const unsigned long ultrIntervalMs = 500UL;               // ultrasonic measurement every 500 ms
const unsigned long PULSEIN_TIMEOUT = 30000UL;            // ~30 ms -> 5 m max for pulseIn

// === Globals ===
TinyGPSPlus gps;
HardwareSerial gpsSerial(2); // Serial2 on ESP32 (RX2=16, TX2=17)

unsigned long lastGpsDisplay = 0;
unsigned long lastUltr = 0;

// === Helper forward declarations ===
long readDistanceCm();
void uploadToFirebase(const char* key, const String &value);
void uploadLocation(double lat, double lon);
bool wifiConnectWithTimeout(unsigned long timeoutMs);

// === Setup ===
void setup() {
  Serial.begin(115200);

  // Ensure motor pin is OFF immediately to avoid power spikes while WiFi starts
  pinMode(MOTOR_PIN, OUTPUT);
  digitalWrite(MOTOR_PIN, LOW);

  // Ultrasonic pins (TRIG idle LOW)
  pinMode(TRIG_PIN, OUTPUT);
  digitalWrite(TRIG_PIN, LOW);
  pinMode(ECHO_PIN, INPUT);

  // Start GPS serial
  gpsSerial.begin(GPS_BAUD, SERIAL_8N1, GPS_RX_PIN, GPS_TX_PIN);

  // WiFi connect (attempt)
  Serial.println();
  Serial.println("Connecting to WiFi...");
  bool connected = wifiConnectWithTimeout(20000); // 20s timeout
  if (!connected) {
    Serial.println("WiFi Failed. Continuing without WiFi.");
  } else {
    Serial.print("WiFi connected. IP: ");
    Serial.println(WiFi.localIP());

    // Firebase init (only when WiFi connected)
    config.api_key = API_KEY;
    config.database_url = DATABASE_URL;
    // Use legacy token if you have it (database secret) — replace below
    config.signer.tokens.legacy_token = FIREBASE_DATABASE_SECRET;
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);
    Serial.println("Firebase initialized.");
  }

  lastGpsDisplay = millis();
}

// === Main loop ===
void loop() {
  // Read GPS incoming chars as they arrive
  while (gpsSerial.available() > 0) {
    char c = gpsSerial.read();
    gps.encode(c);
  }

  unsigned long now = millis();

  // Ultrasonic check at interval
  if (now - lastUltr >= ultrIntervalMs) {
    lastUltr = now;
    long d = readDistanceCm();
    if (d < 0) {
      Serial.println("Distance: Out of range");
      digitalWrite(MOTOR_PIN, LOW);
    } else {
      Serial.print("Distance: ");
      Serial.print(d);
      Serial.println(" cm");
      // Motor logic: vibrate if distance < 100 cm (as you originally intended)
      if (d <= 100) {
        digitalWrite(MOTOR_PIN, HIGH);
      } else {
        digitalWrite(MOTOR_PIN, LOW);
      }
    }
  }

  // GPS upload interval (every minute)
  if (now - lastGpsDisplay >= gpsDisplayIntervalMs) {
    lastGpsDisplay = now;

    // Decide coordinates to upload:
    double useLat = 0.0, useLon = 0.0;
    bool gpsOk = false;

    if (gps.location.isValid()) {
      // Basic sanity checks: tinyGPS sometimes returns 0,0 before valid fix
      double glat = gps.location.lat();
      double glon = gps.location.lng();
      // check not-nan and not effectively zero
      if (!isnan(glat) && !isnan(glon) && !(abs(glat) < 1e-7 && abs(glon) < 1e-7)) {
        useLat = glat;
        useLon = glon;
        gpsOk = true;
      }
    }

    if (!gpsOk) {
      // GPS invalid — use fallback coordinates
      Serial.println("GPS invalid — using fallback coordinates.");
      useLat = FALLBACK_LAT;
      useLon = FALLBACK_LON;
    } else {
      Serial.println("GPS valid — using GPS coordinates.");
    }

    // Print to Serial
    Serial.println(F("-------------------------------------"));
    Serial.print("Upload Lat: ");
    Serial.println(useLat, 6);
    Serial.print("Upload Lon: ");
    Serial.println(useLon, 6);
    Serial.println(F("-------------------------------------"));

    // Attempt Firebase upload only if WiFi connected and Firebase initialized
    if (WiFi.status() == WL_CONNECTED && config.database_url != nullptr && strlen(FIREBASE_DATABASE_SECRET) > 5) {
      // Upload as strings with 6 decimal places
      uploadLocation(useLat, useLon);

      // Also upload a timestamp (UTC if GPS valid, else millis-based fallback)
      String ts;
      if (gps.time.isValid() && gps.date.isValid()) {
        char buf[32];
        sprintf(buf, "20%02d-%02d-%02dT%02d:%02d:%02dZ",
                gps.date.year() % 100, gps.date.month(), gps.date.day(),
                gps.time.hour(), gps.time.minute(), gps.time.second());
        ts = String(buf);
      } else {
        unsigned long t = millis() / 1000;
        ts = String(t);
      }
      uploadToFirebase("ts", ts);
    } else {
      Serial.println("Not uploading to Firebase (no WiFi or Firebase not configured).");
    }
  }

  delay(10);
}

// === Functions ===

long readDistanceCm() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  unsigned long duration = pulseIn(ECHO_PIN, HIGH, PULSEIN_TIMEOUT);
  if (duration == 0) return -1; // out of range / no echo

  long distanceCm = (long)(duration / 58.2); // as in your original code
  return distanceCm;
}

void uploadToFirebase(const char* key, const String &value) {
  String path = String(DEVICE_PATH) + String(key);
  if (Firebase.RTDB.setString(&fbdo, path.c_str(), value.c_str())) {
    Serial.print("✅ Uploaded: ");
    Serial.print(key);
    Serial.print(" = ");
    Serial.println(value);
  } else {
    Serial.print("❌ Failed to upload ");
    Serial.print(key);
    Serial.print(": ");
    Serial.println(fbdo.errorReason());
  }
}

void uploadLocation(double lat, double lon) {
  // Convert to strings with fixed decimals
  char bufLat[32], bufLon[32];
  dtostrf(lat, 0, 6, bufLat);
  dtostrf(lon, 0, 6, bufLon);
  uploadToFirebase("lat", String(bufLat));
  uploadToFirebase("lon", String(bufLon));
}

bool wifiConnectWithTimeout(unsigned long timeoutMs) {
  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASS);

  unsigned long start = millis();
  while (WiFi.status() != WL_CONNECTED) {
    delay(250);
    Serial.print(".");
    if (millis() - start >= timeoutMs) {
      Serial.println();
      return false;
    }
  }
  Serial.println();
  return true;
}
