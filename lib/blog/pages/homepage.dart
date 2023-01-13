import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Blog').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return
                  // ListTile(
                  //   title: Text(data['title']),
                  //   subtitle: Text(data['description']),
                  // );

                  Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: 506,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(children: [
                  // Text(data['title']),
                  // Image.network(data['img']),
                  // Text(data['description']),
                  Text(
                    data['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Image.network(data['img']),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                              data['img'],
                            ),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    data['description'],
                    style: TextStyle(),
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              margin: EdgeInsets.all(15),
                              height: 600,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  Text(
                                    data['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 200,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              data['img'],
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    data['description'],
                                    style: TextStyle(),
                                    textAlign: TextAlign.justify,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Icon(Icons.arrow_back_ios)),
                                  )
                                  // Expanded(
                                  //     child: Image.network(
                                  //   data['img'],
                                  // )),
                                  // Expanded(
                                  //     child: Column(
                                  //   children: [Text(data['title']), Text(data['description'])],
                                  // ))
                                ]),
                              ),
                            ));
                          });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text('See Details')),
                        ),
                        //Text(data['title'])
                      ],
                    ),
                  )
                  // Expanded(
                  //     child: Image.network(
                  //   data['img'],
                  // )),
                  // Expanded(
                  //     child: Column(
                  //   children: [Text(data['title']), Text(data['description'])],
                  // ))
                ]),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
