import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day46/studentmanagement/addcourse.dart';
import 'package:day46/studentmanagement/addcourse2.dart';
import 'package:day46/studentmanagement/viewpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class STMHomePage extends StatefulWidget {
  const STMHomePage({super.key});

  @override
  State<STMHomePage> createState() => STM_HomePageState();
}

class STM_HomePageState extends State<STMHomePage> {

  modalbottom0() {
    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        //barrierColor: Colors.black.withOpacity(.7),
        context: context,
        builder: (context) => AddCourse2());
  }

  //bool img = true;
  // TextEditingController _namecontroller = TextEditingController();
  // TextEditingController _costcontroller = TextEditingController();
  // TextEditingController _coursenamecontroller = TextEditingController();

  // Future sendData() async {
  //   File _imagefile = File(_courseImage!.path);
  //   FirebaseStorage _storage = FirebaseStorage.instance;

  //   UploadTask _uploadTask = _storage
  //       .ref(_courseImage!.name)
  //       .child(_courseImage!.path)
  //       .putFile(_imagefile);

  //   TaskSnapshot _snapshot = await _uploadTask;
  //   _imgUrl = await _snapshot.ref.getDownloadURL();

  //   CollectionReference _courses =
  //       FirebaseFirestore.instance.collection('Student Management');

  //   return _courses.add({
  //     'course_name': _coursenamecontroller.text,
  //     'student_name': _namecontroller.text,
  //     'cost': _costcontroller.text,
  //     'image': _imgUrl,
  //   });
  // }

  // XFile? _courseImage;
  // XFile? _courseImage2;
  // String? _imgUrl;
  //
  // chooseImage() async {
  //   ImagePicker _picker = ImagePicker();
  //   _courseImage = await _picker.pickImage(source: ImageSource.camera);
  //   //img = !img;
  //   setState(() {});
  // }

  // chooseImagegallery() async {
  //   ImagePicker _picker = ImagePicker();
  //   _courseImage2 = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {});
  // }

  // sendData() async {
  //   File _imageFile =File(_courseImage!.path);
  //       //img != true ? File(_courseImage!.path) : File(_courseImage2!.path);
  //
  //   FirebaseStorage _storage = FirebaseStorage.instance;
  //   UploadTask _uploadTask =
  //        _storage
  //           .ref(_courseImage!.name)
  //           .child(_courseImage!.path)
  //           .putFile(_imageFile);
  //
  //   TaskSnapshot _snapshot = await _uploadTask;
  //   _imgUrl = await _snapshot.ref.getDownloadURL();
  //
  //   CollectionReference _courses =
  //       await FirebaseFirestore.instance.collection('courses');
  //   _courses.add({
  //     'course_name': _coursenamecontroller.text,
  //     'student_name': _namecontroller.text,
  //     'cost': _costcontroller.text,
  //     'img': _imgUrl,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.withOpacity(.9),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              modalbottom0();
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          appBar: AppBar(
            title: Text(
              'Student Management',
            ),
            centerTitle: true,
            actions: [Icon(Icons.import_contacts)],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewPage()));
                  },
                  child: Text(
                    'Click here for Student Details',
                    style: TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          )),
    );
  }

//   modalbottom() {
//     return showModalBottomSheet(
//         isDismissible: true,
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         barrierColor: Colors.black.withOpacity(.7),
//         context: context,
//         builder: (context) => Container(
//               //height: 1000,
//               height: MediaQuery.of(context).size.height * .7,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _namecontroller,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'User Name',
//                       hintText: 'Enter Your Name',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextField(
//                     controller: _coursenamecontroller,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Course Name',
//                       hintText: 'Enter Your Course Name',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextField(
//                     controller: _costcontroller,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Cost',
//                       hintText: 'Enter Your Cost',
//                     ),
//                   ),
//                   Expanded(
//                       child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Container(
//                                   width: double.infinity,
//                                   margin: EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     // border: Border.all(
//                                     //     color: Colors.black, width: 2)
//                                   ),
//                                   child: GestureDetector(
//                                       onTap: () {
//
//                                         setState(() {
//                                           chooseImage();
//                                         });
//                                       },
//                                       child: _courseImage == null
//                                           ? Center(
//                                               child:
//                                                   Text('Click via camera  📸'))
//                                           : Image.file(
//                                               File(_courseImage!.path)))),
//
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // Container(
//                       //     width: double.infinity,
//                       //     margin: EdgeInsets.all(20),
//                       //     decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(20),
//                       //         border:
//                       //             Border.all(color: Colors.black, width: 2)),
//                       //     child: GestureDetector(
//                       //         onTap: () {
//                       //           chooseImagegallery();
//                       //         },
//                       //         child: _courseImage == null
//                       //             ? Icon(Icons.browse_gallery_outlined)
//                       //             : Image.file(File(_courseImage!.path)))),
//                     ],
//                   )),
//                   MaterialButton(
//                     height: 40,
//                     onPressed: () {
//                       sendData();
// //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>))
//                       Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(builder: (context) => ViewPage()));
//                      // Navigator.of(context).pop();
//                       //Navigator.pop(context);
//                       // _courseImage2 == null;
//                       // _courseImage == null;
//                       //cleartext();
//                     },
//                     color: Colors.purple.withOpacity(.5),
//                     minWidth: MediaQuery.of(context).size.width * .7,
//                     padding: EdgeInsets.all(10),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Text('Submit'),
//                   )
//                 ],
//               ),
//             ));
//   }
}
