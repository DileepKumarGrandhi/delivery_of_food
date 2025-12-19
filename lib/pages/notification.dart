import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  void _fetchNotifications() async {
    QuerySnapshot snapshot = await _firestore.collection('notifications').get();
    setState(() {
      // Manually defined previous notifications
      List<Map<String, dynamic>> previousNotifications = [
        {
          'title': 'Welcome to FoodShare!',
          'message': 'Thank you for joining us. Let’s work together to minimize food waste!',
          'timestamp': Timestamp.fromDate(DateTime.now().subtract(Duration(days: 2))), // 2 days ago
        },
        {
          'title': 'New Feature Alert',
          'message': 'We have added a new feature for easy food donation!',
          'timestamp': Timestamp.fromDate(DateTime.now().subtract(Duration(days: 1))), // 1 day ago
        },
        {
          'title': 'Reminder',
          'message': 'Don’t forget to check your food donations regularly.',
          'timestamp': Timestamp.fromDate(DateTime.now().subtract(Duration(hours: 5))), // 5 hours ago
        },
      ];

      // Merge previous notifications with fetched ones
      notifications = previousNotifications +
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification['title']),
            subtitle: Text(notification['message']),
            trailing: Text(notification['timestamp'].toDate().toString()),
          );
        },
      ),
    );
  }
}
