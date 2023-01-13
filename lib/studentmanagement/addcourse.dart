

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _costcontroller = TextEditingController();
  TextEditingController _coursenamecontroller = TextEditingController();

  XFile? _courseImage;
  //XFile? _courseImage2;
  String? _imgUrl;

  chooseImage() async {
    ImagePicker _picker = ImagePicker();
    _courseImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {

    });
  }

  sendData() async {
    File _imageFile = File(_courseImage!.path);
    //img != true ? File(_courseImage!.path) : File(_courseImage2!.path);

    FirebaseStorage _storage = FirebaseStorage.instance;
    // UploadTask _uploadTask = img != true
    //     ? _storage
    //     .ref(_courseImage!.name)
    //     .child(_courseImage!.path)
    //     .putFile(_imageFile)
    //     : _storage
    //     .ref(_courseImage2!.name)
    //     .child(_courseImage2!.path)
    //     .putFile(_imageFile);
    UploadTask _uploadTask = _storage
        .ref(_courseImage!.name)
        .child(_courseImage!.path)
        .putFile(_imageFile);
    TaskSnapshot _snapshot = await _uploadTask;
    _imgUrl = await _snapshot.ref.getDownloadURL();

    CollectionReference _courses =
    await FirebaseFirestore.instance.collection('courses');
    _courses.add({
      'course_name': _coursenamecontroller.text,
      'student_name': _namecontroller.text,
      'cost': _costcontroller.text,
      'img': _imgUrl,
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 1000,
      height: MediaQuery.of(context).size.height * .7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _namecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
              hintText: 'Enter Your Name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _coursenamecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Course Name',
              hintText: 'Enter Your Course Name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _costcontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cost',
              hintText: 'Enter Your Cost',
            ),
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                              width: 300,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // border: Border.all(
                                //     color: Colors.black, width: 2)
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    chooseImage();
                                    setState(() {

                                    });

                                  },
                                  child: _courseImage == null
                                      ? Center(
                                      child:
                                      Text('Click via camera  📸'))
                                      : Image.file(
                                      File(_courseImage!.path)))),
                          // Container(
                          //   width: double.infinity,
                          //   margin: EdgeInsets.all(20),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     // border: Border.all(
                          //     //     color: Colors.black, width: 2)
                          //   ),
                          //   child: GestureDetector(
                          //       onTap: () {
                          //         chooseImagegallery();
                          //       },
                          //       child: _courseImage2 == null
                          //           ? Center(
                          //           child: Text(
                          //               "Choose from Gallery  🖼️"))
                          //           : Image.file(
                          //           File(_courseImage2!.path))),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  // Container(
                  //     width: double.infinity,
                  //     margin: EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         border:
                  //             Border.all(color: Colors.black, width: 2)),
                  //     child: GestureDetector(
                  //         onTap: () {
                  //           chooseImagegallery();
                  //         },
                  //         child: _courseImage == null
                  //             ? Icon(Icons.browse_gallery_outlined)
                  //             : Image.file(File(_courseImage!.path)))),
                ],
              )),
          MaterialButton(
            height: 40,
            onPressed: () {
              sendData();
              Navigator.of(context).pop();
            },
            color: Colors.purple.withOpacity(.5),
            minWidth: MediaQuery.of(context).size.width * .7,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
