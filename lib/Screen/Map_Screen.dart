import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  final DatabaseReference _deviceRef = FirebaseDatabase.instance.ref(
    'devices/device_001',
  );

  double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  LatLng _currentLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();

    _deviceRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        double lat = toDouble(data['lat']);
        double lon = toDouble(data['lon']);

        setState(() {
          _currentLocation = LatLng(lat, lon);
        });

        _mapController.move(_currentLocation, _mapController.camera.zoom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //  LatLng markerpos = LatLng(0, 10);
    return (Scaffold(
      appBar: AppBar(
        title: Text("Live Location", style: TextStyle(color: Colors.white)),
        iconTheme: CupertinoIconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: 13,

                 cameraConstraint: CameraConstraint.contain(
    bounds: LatLngBounds(
      LatLng(-85, -180),
      LatLng(85, 180),
    ),
  ),
              
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "com.guardian.app",

                  keepBuffer: 0,
                  tileBounds: LatLngBounds(
                    LatLng(-85.0511, -180),
                    LatLng(85.0511, 180),
                  ),

                  maxNativeZoom: 19,
                  minZoom: 3,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation,
                      child: Icon(
                        CupertinoIcons.location_solid,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
