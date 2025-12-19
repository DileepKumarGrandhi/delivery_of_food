import 'package:deliveryoffood/pages/signup.dart';
import 'package:deliveryoffood/widget/widget_support.dart';
import 'package:flutter/material.dart';

import '../widget/content_model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int CurrentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded( // Consider wrapping PageView.builder with Expanded
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    CurrentIndex = index;
                  });
                },
                itemBuilder: (_, i) { // Corrected parameter name
                  return Padding(
                    padding: EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 40.0,),
                        Text(contents[i].title,style: Appwidget.SemiBoldTextFieldStyle(),),
                        SizedBox(height: 20.0,),
                        Text(contents[i].description,style:Appwidget.LightTextFieldStyle())// Added semicolon here
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(contents.length, (index)=>
                    buildDot(index,context),
                )
            ) ,
          ),
          GestureDetector(
            onTap: (){
              if(CurrentIndex==contents.length-1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()),);
              };
              _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
            },
            child: Container(
                decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(20)),
                height: 60,
                margin: EdgeInsets.all(40),
                width: double.infinity,
                child: Center(child:
                Text(CurrentIndex==contents.length-1?"Start":"Next",
                  style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),))
            ),
          ),
        ],
      ),
    );
  }
  Container buildDot(int index,BuildContext context){
    return Container(
      height :10.0,
      width: CurrentIndex==index?18:7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black38),

    );
  }
}