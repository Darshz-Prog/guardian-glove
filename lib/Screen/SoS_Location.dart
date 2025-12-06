import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class SosLocation extends StatelessWidget {
  final Map<dynamic, dynamic>? cords;

  SosLocation({super.key, required this.cords});

  final _mapcontroller = MapController();
  // final _currloc = LatLng(cords['lat'], cords['lon']);
  @override
  Widget build(BuildContext context) {
   final lat = (cords?['lat'] as num?)?.toDouble() ?? 0.0;
    final lon = (cords?['lon'] as num?)?.toDouble() ?? 0.0;
    final ts = cords?['ts']?.toString() ?? "Unknown";
    return (Scaffold(
      appBar: AppBar(
        title: Text(
          "Location Time: $ts",
          style: GoogleFonts.albertSans(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapcontroller,
            options: MapOptions(initialCenter: LatLng(lat, lon)),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(lat,lon),
                    child: Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
