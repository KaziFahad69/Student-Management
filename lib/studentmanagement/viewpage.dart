import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day46/studentmanagement/addcourse.dart';
import 'package:day46/studentmanagement/updatecourse.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  showTost() {
    Fluttertoast.showToast(
        msg: 'Item Deleted',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.yellow
    );
  }

  modalbottom() {
    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        //barrierColor: Colors.black.withOpacity(.7),
        context: context,
        builder: (context) => AddCourse());
  }
  updatecourse(documentId, studentname, coursename, coursefee, img ) {
    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        //barrierColor: Colors.black.withOpacity(.7),
        context: context,
        builder: (context) => UpdateCourse(documentId, studentname, coursename, coursefee, img ));
  }

  // student_info.doc(documentid).update({
  // 'Course_Name': _cousenameController.text,
  // 'Course_Code': _cousecodeController.text,
  // 'Course_Fee': _cousefeeController.text,
  // 'Course_Image': _imageURL,
  // }).then((value) => print('Updated'));

  Future<void> deletecourse(documenteId) {
    return FirebaseFirestore.instance
        .collection("courses")
        .doc(documenteId)
        .delete()
        .then((value) =>
        showTost(

        )
    ).catchError((error) => print("Failed to update user: $error"));
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('courses').snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            modalbottom();
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(.3),
          title: Text(
            'All students informations',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      height: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            data['img'],
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(.6),
                                  shape: BoxShape.circle),
                              child: Text(
                                data['student_name'][0],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  data['student_name'],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data['course_name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  data['cost'],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          child: Container(
                                        height: 600,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.network(
                                                data['img'],
                                                height: 300,
                                                width: 200,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Student Name: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            "${data['student_name']}",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .wavy,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Program: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            "${data['course_name']}",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Total Cost: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "${data['cost']}",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .wavy,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // showDialog(context: context, builder: (context){
                                                  //   return Dialog(child: );
                                                  // });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Icon(Icons
                                                          .arrow_back_sharp)),
                                                ),
                                              )
                                            ]),
                                      ));
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('See more..'),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 30,
                        right: 30,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                updatecourse(document.id,data['student_name'],data['course_name'],data['cost'],data['img']);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.edit),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                deletecourse(document.id);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.remove_circle),
                              ),
                            ),
                          ],
                        ))
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
