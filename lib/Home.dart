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

  Future gettBlocData() async {
    var firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection("Blog").getDocuments();
    return snapshot.documents;
  }

  Future getRefresh() async {
    Future.delayed(Duration(seconds: 3));
    setState(() {
      gettBlocData();
    });
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
                  ourBlocData(context)
                ],
              ),
            )


          ],
        ),

      ),

    );
  }

  //bloc data function

  Widget ourBlocData(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: FutureBuilder(
          future: gettBlocData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: getRefresh,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      var Ourdata = snapshot.data[index];
                      return Container(
                        height: 250.0,
                        child: Card(
                          elevation: 10.0,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(Ourdata.data['img'],
                                    fit: BoxFit.cover,
                                    height: 250.0,
                                  ),
                                ),
                              ),

                              SizedBox(width: 10.0,),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[

                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(Ourdata.data['name'],
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 15.0),
                                            child: InkWell(
                                              onTap: () {
                                                blocBottomSheet(context,
                                                    Ourdata.data['img'],
                                                    Ourdata.data['name'],
                                                    Ourdata.data['des']
                                                );
                                              },
                                              child: Icon(Icons.more_horiz,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Text(Ourdata.data['des'],
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )


                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            }
          }
      ),
    );
  }

  Widget blocBottomSheet(BuildContext context, String img, String name,
      String des) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.all(10.0),
                child: Container(
                  
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Column(
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 5.0,
                        width: 70.0,
                        color: Colors.grey,
                      ),

                      Container(
                        height: 250.0,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          borderRadius: BorderRadius.circular(20.0),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.green.withOpacity(0.1), BlendMode.dstATop),
                            image: new NetworkImage(img),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[

                            CircleAvatar(
                              child: Text(name[0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.black,
                              maxRadius: 25.0,
                            ),
                            SizedBox(width: 10.0,),
                            Text(name, style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                            ),)

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(des,style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black
                        ),),
                      )


                    ],
                  ),
                ),
              )
              ,
            )
            ,
          );
        }
    );
  }

}




