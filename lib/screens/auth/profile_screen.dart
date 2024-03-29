import 'dart:io';
import 'package:firebase_todo_app/screens/auth/update_profile.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_todo_app/screens/home_screen.dart';
import 'package:firebase_todo_app/screens/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import '../../Controller/home_screen_controller.dart';
import '../../utility/utility.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  DocumentSnapshot? userSnapshot;
  File? imageFile;
  bool showLocalFile = false;

  getUserDetails() async {

    String uid = FirebaseAuth.instance.currentUser!.uid;
    userSnapshot =  await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
    });
  }

  _pickImageFrom(ImageSource imageSource) async {

    XFile? xFile = await ImagePicker().pickImage(source: imageSource);

    if (xFile == null) return;

    final tempImage = File(xFile.path);

    imageFile = tempImage;
    showLocalFile = true;
    setState(() {});

    // upload to firebase storage

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading !!!'),
      message: const Text('Please wait'),
    );
    progressDialog.show();

    try {
      var fileName = userSnapshot!['email'] + '.jpg';

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName)
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;

      String profileImageUrl = await snapshot.ref.getDownloadURL();

      profileController.imageGet.value = false;

      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'profileImage': profileImageUrl});

      Fluttertoast.showToast(msg: 'Profile image uploaded');
       showLocalFile = false;
      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }
  final HomeScreenController profileController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
        ),
        body: userSnapshot == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 80,
                      backgroundImage: showLocalFile
                          ? FileImage(imageFile!) as ImageProvider
                          : NetworkImage(userSnapshot!['profileImage'])),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text('From Gallery'),
                                    onTap: () {
                                      _pickImageFrom(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('From Camera'),
                                    onTap: () {
                                      _pickImageFrom(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Name :",style: TextStyle(fontSize: 18),),
                            Row(
                              children: [

                                Text(
                                  userSnapshot!['firstName'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  userSnapshot!['lastName'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                                // Obx(() => Text(profileController.firstName.toString(), style: const TextStyle(fontSize: 18), )  ),
                                // Obx(() => Text(profileController.lastName.toString(), style: const TextStyle(fontSize: 18), )  ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Email : ",style: TextStyle(fontSize: 18),),
                            Text(
                              userSnapshot!['email'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Joined",style: TextStyle(fontSize: 18),),
                            Text(
                              Utility.getHumanReadableDate(userSnapshot!['dt']),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),

                        IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreenUI()),
                          );
                        }, icon: const Icon(Icons.person))

                      ],
                    ),
                  ),
                ),
              ),

             ElevatedButton(onPressed: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
               );
             }, child: const Text("Update Profile") )
            ],
          ),
        ));
  }
}