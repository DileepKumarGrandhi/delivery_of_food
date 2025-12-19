import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(16.8306, 81.5265),
          zoom: 14,
        ),
      ),
    );
  }
}
