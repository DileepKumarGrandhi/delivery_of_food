import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryCoordinationPage extends StatefulWidget {
  @override
  _DeliveryCoordinationPageState createState() => _DeliveryCoordinationPageState();
}

class _DeliveryCoordinationPageState extends State<DeliveryCoordinationPage> {
  List<DeliveryItem> deliveries = [];

  @override
  void initState() {
    super.initState();
    _initializeDefaultDeliveries(); // Initialize with default deliveries
    _loadDeliveries(); // Load deliveries from Firestore
  }

  void _initializeDefaultDeliveries() {
    deliveries = [
      DeliveryItem(
        id: '1',
        name: 'Food Donation to Orphanage A',
        status: 'Scheduled',
        pickupLocation: '123 Main St, City',
        deliveryLocation: 'Orphanage A, City',
      ),
      DeliveryItem(
        id: '2',
        name: 'Food Donation to Orphanage B',
        status: 'In Transit',
        pickupLocation: '456 Elm St, City',
        deliveryLocation: 'Orphanage B, City',
      ),
      DeliveryItem(
        id: '3',
        name: 'Food Donation to Community Center',
        status: 'Delivered',
        pickupLocation: '789 Pine St, City',
        deliveryLocation: 'Community Center, City',
      ),
    ];
  }

  Future<void> _loadDeliveries() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('deliveries') // Your Firestore collection name
        .get();

    setState(() {
      deliveries.addAll(querySnapshot.docs.map((doc) {
        return DeliveryItem(
          id: doc.id, // Get the document ID
          name: doc['name'], // Replace with your field names
          status: doc['status'], // Replace with your field names
          pickupLocation: doc['pickupLocation'], // Example field
          deliveryLocation: doc['deliveryLocation'], // Example field
        );
      }).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Coordination'),
      ),
      body: deliveries.isEmpty // Check if deliveries list is empty
          ? Center( // Display a message in the center of the screen
        child: Text(
          'No deliveries scheduled yet.', // Your message
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(deliveries[index].name),
            subtitle: Text('Status: ${deliveries[index].status}'),
            onTap: () {
              // Navigate to detailed view if needed
            },
          );
        },
      ),
    );
  }
}

// DeliveryItem class to hold data for each delivery item
class DeliveryItem {
  final String id; // Document ID
  final String name;
  final String status;
  final String pickupLocation;
  final String deliveryLocation;

  DeliveryItem({
    required this.id,
    required this.name,
    required this.status,
    required this.pickupLocation,
    required this.deliveryLocation,
  });
}
