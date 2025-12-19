import 'package:deliveryoffood/pages/details.dart';
import 'package:deliveryoffood/pages/notification.dart'; // Import your notification page
import 'package:deliveryoffood/pages/pickupScheduling.dart'; // Import your pickup scheduling page
import 'package:deliveryoffood/pages/deliverycoordination.dart'; // Import your delivery coordination page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deliveryoffood/widget/widget_support.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String? name;
  List<FoodItem> foodItems = [];
  String selectedCategory = 'FullMeal'; // Default category
  bool fruits = false, fullmeal = true, tiffin = false, vegetables = false;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadFoodItems(selectedCategory); // Load default category items
  }

  Future<void> _loadUsername() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'];
        });
      }
    }
  }

  Future<void> _loadFoodItems(String category) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(category)
        .get();

    setState(() {
      foodItems = querySnapshot.docs.map((doc) {
        return FoodItem(
          doc['Name'],         // Retrieves the 'Name' field
          doc['Detail'],       // Retrieves the 'Detail' field
          doc['Image'],        // Retrieves the 'Image' field
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 50.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello ${name ?? 'User'},",
                    style: Appwidget.boldTextFieldStyle(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                "Tastes to Share",
                style: Appwidget.HeadlineTextFieldStyle(),
              ),
              Text(
                "Join the Community of Food Share",
                style: Appwidget.LightTextFieldStyle(),
              ),
              const SizedBox(height: 20.0),
              Container(margin: const EdgeInsets.only(right: 20.0), child: showItem()),
              const SizedBox(height: 30.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: foodItems
                      .map((foodItem) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(foodItem: foodItem),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 280,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                foodItem.imagePath,
                                height: 150.0,
                                width: 160.0,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                foodItem.name,
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                              Text(
                                foodItem.description,
                                style: Appwidget.LightTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
              SizedBox(height: 130.0),
              // Add navigation buttons for the new pages
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationPage()),
                        );
                      },
                      child: Text('Notifications'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PickupSchedulingPage()),
                        );
                      },
                      child: Text('Schedule Pickup'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeliveryCoordinationPage()),
                        );
                      },
                      child: Text('Coordinate Delivery'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        categoryButton("Full Meal", "assets/images/fullmeal.png", fullmeal, () {
          setState(() {
            fruits = false;
            fullmeal = true;
            tiffin = false;
            vegetables = false;
            selectedCategory = 'FullMeal';
          });
          _loadFoodItems('FullMeal');
        }),
        categoryButton("Fruits", "assets/images/Fruits.png", fruits, () {
          setState(() {
            fruits = true;
            fullmeal = false;
            tiffin = false;
            vegetables = false;
            selectedCategory = 'Fruits';
          });
          _loadFoodItems('Fruits');
        }),
        categoryButton("Tiffin", "assets/images/Tiffins.png", tiffin, () {
          setState(() {
            fruits = false;
            fullmeal = false;
            tiffin = true;
            vegetables = false;
            selectedCategory = 'Tiffins';
          });
          _loadFoodItems('Tiffins');
        }),
        categoryButton("Vegetables", "assets/images/vegetables.png", vegetables, () {
          setState(() {
            fruits = false;
            fullmeal = false;
            tiffin = false;
            vegetables = true;
            selectedCategory = 'Vegetables';
          });
          _loadFoodItems('Vegetables');
        }),
      ],
    );
  }

  Widget categoryButton(String title, String iconPath, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                iconPath,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// FoodItem class to hold data for each food item
class FoodItem {
  final String name;
  final String description;
  final String imagePath;

  FoodItem(this.name, this.description, this.imagePath);
}
