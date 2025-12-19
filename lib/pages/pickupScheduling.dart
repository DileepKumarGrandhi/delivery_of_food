import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PickupSchedulingPage extends StatefulWidget {
  @override
  _PickupSchedulingPageState createState() => _PickupSchedulingPageState();
}

class _PickupSchedulingPageState extends State<PickupSchedulingPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _schedulePickup() async {
    if (_dateController.text.isNotEmpty && _timeController.text.isNotEmpty) {
      await _firestore.collection('pickup_requests').add({
        'date': _dateController.text,
        'time': _timeController.text,
        'status': 'Scheduled',
        'created_at': FieldValue.serverTimestamp(),
      });

      // Clear the input fields
      _dateController.clear();
      _timeController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup scheduled successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Pickup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Pickup Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Pickup Time (HH:MM)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _schedulePickup,
              child: Text('Schedule Pickup'),
            ),
          ],
        ),
      ),
    );
  }
}
