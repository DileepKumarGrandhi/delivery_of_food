import 'package:deliveryoffood/pages/order.dart'; // Add this import
import 'package:deliveryoffood/pages/home.dart';
import 'package:deliveryoffood/widget/widget_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final FoodItem foodItem;

  const Details({super.key, required this.foodItem});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  List<String> orders = []; // Keep track of orders locally for now

  void addToCart() {
    // Add the food item to orders list
    for (var i = 0; i < quantity; i++) {
      orders.add(widget.foodItem.name); // Add the item name
    }

    // Navigate to Order page with the updated list of orders
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Order(),
      ),
    );

    // Show snackbar for confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.foodItem.name} added to orders"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            ),
            SizedBox(height: 15.0),
            Image.network(
              widget.foodItem.imagePath,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.foodItem.name,
                        style: Appwidget.SemiBoldTextFieldStyle(),
                      ),
                      Text(
                        widget.foodItem.description,
                        style: Appwidget.boldTextFieldStyle(),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                _buildQuantityControl(),
              ],
            ),

            SizedBox(height: 20.0),

            Text(
              "Customize your order quantity for a personalized experience.",
              style: Appwidget.LightTextFieldStyle(),
              maxLines: 3,
            ),
            SizedBox(height: 30.0),

            Spacer(),
            _buildAddToCartSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControl() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (quantity > 1) {
              setState(() {
                quantity--;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.remove, color: Colors.white),
          ),
        ),
        SizedBox(width: 20.0),
        Text(quantity.toString(), style: Appwidget.SemiBoldTextFieldStyle()),
        SizedBox(width: 20.0),
        GestureDetector(
          onTap: () {
            setState(() {
              quantity++;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total items", style: Appwidget.SemiBoldTextFieldStyle()),
              Text("Count: $quantity", style: Appwidget.HeadlineTextFieldStyle()),
            ],
          ),
          GestureDetector(
            onTap: addToCart, // Call addToCart method on tap
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
