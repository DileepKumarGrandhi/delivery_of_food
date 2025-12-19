import 'package:deliveryoffood/pages/bottomnav.dart';
import 'package:deliveryoffood/pages/forgotpassword.dart';
import 'package:deliveryoffood/pages/signup.dart';
import 'package:deliveryoffood/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class logIn extends StatefulWidget {
  const logIn({super.key});

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  String username="",password="";
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Bottomnav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "No User Found for that username",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFff5c30),
                        Color(0xFFe74b1a),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3,
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Text(""),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo2.png",
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 30.0),
                                  Text(
                                    "Login",
                                    style: Appwidget.HeadlineTextFieldStyle(),
                                  ),
                                  SizedBox(height: 30.0),
                                  TextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Username is required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: Appwidget.SemiBoldTextFieldStyle(),
                                      prefixIcon: Icon(Icons.email_rounded),
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: Appwidget.SemiBoldTextFieldStyle(),
                                      prefixIcon: Icon(Icons.password_outlined),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => forgotPassword()),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Forgot Password?",
                                        style: Appwidget.SemiBoldTextFieldStyle(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50.0),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          username = _usernameController.text;
                                          password = _passwordController.text;
                                        });
                                        userLogin();
                                      }
                                    },
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Color(0xffff5722),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: 'Poppins1',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
              child: Text(
                "Don't have an account? Sign up",
                style: Appwidget.SemiBoldTextFieldStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
