
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCourse extends StatefulWidget {
  String documentId;
  String studentname;
  String coursename;
  String coursefee;
  String img;


  UpdateCourse(this.documentId, this.studentname, this.coursename,
      this.coursefee, this.img);

  @override
  State<UpdateCourse> createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller.text = widget.studentname;
    _coursenamecontroller.text = widget.coursename;
    _costcontroller.text= widget.coursefee;


  }

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
  // Future<void> deletecourse(documentIds) {
  //   return FirebaseFirestore.instance
  //       .collection("courses")
  //       .doc(documentIds)
  //       .delete()
  //       .then((value) =>
  //       showTost(
  //
  //       )
  //   );
  // }

  sendData(selectdDocument) async {

    if(_courseImage == null){
      CollectionReference _courses =
      await FirebaseFirestore.instance.collection('courses');
      // _courses.add({
      //   'course_name': _coursenamecontroller.text,
      //   'student_name': _namecontroller.text,
      //   'cost': _costcontroller.text,
      //   'img': widget.img,
      // });

      _courses.doc(selectdDocument).update({
          'course_name': _coursenamecontroller.text,
          'student_name': _namecontroller.text,
          'cost': _costcontroller.text,
          'img': widget.img,
      }).then((value) => print('Updated'));

    }
    else{
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
      // _courses.add({
      //   'course_name': _coursenamecontroller.text,
      //   'student_name': _namecontroller.text,
      //   'cost': _costcontroller.text,
      //   'img': _imgUrl,
      // });
      _courses.doc(selectdDocument).update({
        'course_name': _coursenamecontroller.text,
        'student_name': _namecontroller.text,
        'cost': _costcontroller.text,
        'img': _imgUrl,
      }).then((value) => print('Updated'));
    }


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
              child: Column(
                children: [
                  Container(
                    height: 200,
                      width: 300,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            chooseImage();
                            setState(() {
                            });
                          },
                          child: _courseImage == null
                              ? Stack(
                                children: [
                                  Image.network(widget.img,height: 200,width: 300,),
                                  Positioned(
                                      right: 75,
                                      child: GestureDetector(
                                        onTap: (){
                                              chooseImage();
                                              // setState(() {
                                              //
                                              // });
                                        },
                                        child: Card(
                                    child: Icon(Icons.edit),
                                  ),
                                      ))
                                ],
                              )
                              : Image.file(
                              File(_courseImage!.path)))),
                ],
              )),
          MaterialButton(
            height: 40,
            onPressed: () {
              sendData(widget.documentId);

              Navigator.of(context).pop();
            },
            color: Colors.purple.withOpacity(.5),
            minWidth: MediaQuery.of(context).size.width * .7,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Text('Update Course'),
          )
        ],
      ),
    );
  }

}
