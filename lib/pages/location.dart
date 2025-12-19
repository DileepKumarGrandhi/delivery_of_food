import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? selectedCity;
  String? selectedArea;
  bool _isButtonEnabled = false;

  final Map<String, LatLng> cityCoordinates = {
    'Vijayawada': LatLng(16.54235599112739, 80.62721391108362),
    'Visakhapatnam': LatLng(17.6868, 83.2185),
    'Guntur': LatLng(16.3067, 80.4365),
    'Nellore': LatLng(14.4422, 79.9866),
    'Kurnool': LatLng(15.8272, 78.0389),
    'Rajahmundry': LatLng(17.0039, 81.8254),
    'Kakinada': LatLng(16.9827, 82.0029),
    'Tirupati': LatLng(13.6288, 79.4192),
    'Anantapur': LatLng(14.6810, 77.6000),
    'Kadapa': LatLng(14.4780, 78.8205),
    'Eluru': LatLng(16.7062, 81.1075),
    'Machilipatnam': LatLng(16.1862, 81.1316),
    'Ongole': LatLng(15.5050, 80.0488),
    'Srikakulam': LatLng(18.2944, 83.8985),
    'Chittoor': LatLng(13.2267, 78.7335),
  };

  final List<String> areas = [
    'Orphanages', 'Old Age Homes', 'Food Banks', 'Community Centers'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text('Location', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal)),
              SizedBox(height: 20),

              // City Dropdown
              DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: InputDecoration(filled: true, fillColor: Colors.grey[200]),
                items: cityCoordinates.keys.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                onChanged: (newValue) => setState(() {
                  selectedCity = newValue;
                  _isButtonEnabled = selectedCity != null && selectedArea != null;
                }),
              ),
              SizedBox(height: 20),

              // Area Dropdown
              DropdownButtonFormField<String>(
                value: selectedArea,
                decoration: InputDecoration(filled: true, fillColor: Colors.grey[200]),
                items: areas.map((area) => DropdownMenuItem(value: area, child: Text(area))).toList(),
                onChanged: (newValue) => setState(() {
                  selectedArea = newValue;
                  _isButtonEnabled = selectedCity != null && selectedArea != null;
                }),
              ),
              SizedBox(height: 40),

              // Continue Button
              ElevatedButton(
                onPressed: _isButtonEnabled ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapPage(
                        city: selectedCity!,
                        areaType: selectedArea!,
                        initialCameraPosition: cityCoordinates[selectedCity!]!,
                      ),
                    ),
                  );
                } : null,
                child: Text('Continue', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  final String city;
  final String areaType;
  final LatLng initialCameraPosition;

  MapPage({required this.city, required this.areaType, required this.initialCameraPosition});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  bool _isMapLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMarkersFromFirestore();
  }

  void _fetchMarkersFromFirestore() async {
    FirebaseFirestore.instance
        .collection('locations')
        .where('city', isEqualTo: widget.city)
        .where('type', isEqualTo: widget.areaType)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        GeoPoint geoPoint = doc['location'];
        _markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(geoPoint.latitude, geoPoint.longitude),
            infoWindow: InfoWindow(
              title: doc['name'],
              snippet: doc['description'],
            ),
          ),
        );
      }

      // Add custom markers based on area type and city
      _addCustomMarkers();

      setState(() {
        _isMapLoading = false;
      });
    });
  }

  void _addCustomMarkers() {
    final customLocations = {
      'Vijayawada': {
        'Orphanages': [LatLng(16.5147, 80.6312),LatLng(16.536065198860673, 80.5969426839103)],
        'Old Age Homes': [LatLng(16.5132, 80.6174)],
        'Food Banks': [LatLng(16.5151, 80.6283)],
        'Community Centers': [LatLng(16.5135, 80.6141)]
      },
      'Visakhapatnam': {
        'Orphanages': [LatLng(17.6868, 83.2185)],
        'Old Age Homes': [LatLng(17.7225, 83.3121)],
        'Food Banks': [LatLng(17.6947, 83.3042)],
        'Community Centers': [LatLng(17.7018, 83.2995)]
      },
      'Guntur': {
        'Orphanages': [LatLng(16.2978, 80.4367)],
        'Old Age Homes': [LatLng(16.3063, 80.4404)],
        'Food Banks': [LatLng(16.3045, 80.4361)],
        'Community Centers': [LatLng(16.2994, 80.4338)]
      },
      'Nellore': {
        'Orphanages': [LatLng(14.4420, 79.9868)],
        'Old Age Homes': [LatLng(14.4427, 79.9891)],
        'Food Banks': [LatLng(14.4415, 79.9873)],
        'Community Centers': [LatLng(14.4431, 79.9884)]
      },
      'Kurnool': {
        'Orphanages': [LatLng(15.8237, 78.0369)],
        'Old Age Homes': [LatLng(15.8289, 78.0391)],
        'Food Banks': [LatLng(15.8255, 78.0378)],
        'Community Centers': [LatLng(15.8263, 78.0382)]
      },
      'Rajahmundry': {
        'Orphanages': [LatLng(17.0005, 81.8040)],
        'Old Age Homes': [LatLng(17.0023, 81.8065)],
        'Food Banks': [LatLng(17.0032, 81.8051)],
        'Community Centers': [LatLng(17.0011, 81.8072)]
      },
      'Kakinada': {
        'Orphanages': [LatLng(16.9891, 82.2475)],
        'Old Age Homes': [LatLng(16.9887, 82.2459)],
        'Food Banks': [LatLng(16.9876, 82.2462)],
        'Community Centers': [LatLng(16.9893, 82.2481)]
      },
    };

    if (customLocations.containsKey(widget.city) && customLocations[widget.city]!.containsKey(widget.areaType)) {
      for (LatLng location in customLocations[widget.city]![widget.areaType]!) {
        _markers.add(
          Marker(
            markerId: MarkerId('${widget.city}_${widget.areaType}_${location.latitude}'),
            position: location,
            infoWindow: InfoWindow(
              title: '${widget.areaType} in ${widget.city}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donation Locations in ${widget.city}')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: widget.initialCameraPosition,
              zoom: 14,
            ),
            mapType: MapType.normal,
            markers: _markers,
          ),
          if (_isMapLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
