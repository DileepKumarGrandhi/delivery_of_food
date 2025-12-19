import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deliveryoffood/pages/home.dart';
import 'package:deliveryoffood/pages/location.dart';
import 'package:deliveryoffood/pages/order.dart';
import 'package:deliveryoffood/pages/profile.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex = 0;
  late List<Widget>pages;
  late Widget currentPage;
  late home homepage;
  late Profile profile;
  late Order order;
  late LocationPage location;

  @override
  void initState() {
    homepage = home();
    order = Order();
    profile = Profile();
    location = LocationPage();
    pages = [homepage, order, location, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}