
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {

  RxBool imageGet = false.obs;
  String imageFile = "";

  DocumentSnapshot? userSnapshot;

  void getFirebaseData() async {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    userSnapshot =  await FirebaseFirestore.instance.collection('users').doc(uid).get();
     imageGet.value = true;
     imageFile = userSnapshot!['profileImage'];
  }

}