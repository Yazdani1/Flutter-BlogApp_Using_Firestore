import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  String img1 = "https://images.pexels.com/photos/3689772/pexels-photo-3689772.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  String img2 = "https://images.pexels.com/photos/1115804/pexels-photo-1115804.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  String img3 = "https://images.pexels.com/photos/3771836/pexels-photo-3771836.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img4 = "https://images.pexels.com/photos/3771113/pexels-photo-3771113.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";

  Future gettBlocData() async{
    var firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection("Blog").getDocuments();
    return snapshot.documents;
  }

  



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Carousol slider
            Container(
                height: 250.0,
                child: Carousel(
                  images: [
                    NetworkImage(img1),
                    NetworkImage(img2),
                    NetworkImage(img3),
                    NetworkImage(img4),
                  ],
                  dotSize: 8.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  borderRadius: true,
                )
            ),

            //bloc data
            Container(
              child: Column(
                children: <Widget>[
                  ourBlocData(context),
                ],
              ),
            )

          ],
        ),
      ),

    );
  }

  //bloc data function

 Widget ourBlocData(BuildContext context){
    return Container(

    );
 }


}




