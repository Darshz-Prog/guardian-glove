# Guardian Glove

Guardian Glove is a lightweight wearable monitoring system combining Arduino-based sensing with a Flutter application. It delivers real-time data visualization, event detection, and wireless communication for safety and research applications.

---

## Overview

The system captures sensor data from a glove-mounted hardware module, processes it on an Arduino, and streams it to a cross-platform Flutter application. The app provides live monitoring, threshold-based alerts, and structured data output.

---

## Key Features

- Real-time sensor data acquisition  
- Wireless data transmission  
- Event and anomaly detection  
- Cross-platform Flutter application  
- Modular and extensible hardware design  
- Support for multiple sensor types  

---

## Applications

- Personal and workplace safety  
- Health and movement monitoring  
- Wearable prototyping  
- IoT research and development  

---

## Project Goal

To provide a simple and scalable wearable platform capable of real-time sensing, wireless communication, and multi-platform visualization.

---

## Technology Stack

### Hardware
- Arduino  
- Motion and environmental sensors  
- Bluetooth / WiFi communication  

### Software
- Flutter  
- Dart  

### Supported Platforms
- Android  
- iOS  
- Web  
- Windows  
- Linux  
- macOS  

---

## Architecture

1. Hardware sensors collect continuous data.  
2. Arduino preprocesses and packages sensor readings.  
3. The data is transmitted wirelessly to the mobile device.  
4. The Flutter app visualizes readings and manages alert logic.  

---

## Directory Structure

```
guardian-glove/
├── lib/                 # Flutter source code
├── assets/              # App assets
├── Guardion-Glove/      # Arduino firmware
├── android/
├── ios/
├── web/
├── windows/
├── linux/
├── macos/
├── test/
├── pubspec.yaml
└── README.md
```

---

## Setup Instructions

### Flutter
```bash
flutter doctor
flutter pub get
flutter run
```

### Arduino
- Open the firmware folder in Arduino IDE  
- Select the correct board and communication port  
- Upload the sketch to the device  

---


## License

Available for educational, research, and development use under [MIT License](LICENSE).
