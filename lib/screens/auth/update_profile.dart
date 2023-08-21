import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const  Text("Update the User Data"),
                const SizedBox(height: 50,),
               Container(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SingleChildScrollView(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const SizedBox(height: 20,),
                         const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.black),),
                         const SizedBox(height: 10,),
                         const Text("It's quick and easy.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.black),),
                         const SizedBox(height: 20,),
                         Container(
                           child: Row(
                             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Expanded(
                                 flex: 1,
                                 child: TextField(
                                   controller: firstnameController,
                                   decoration: const InputDecoration(
                                       contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                       filled: true,
                                       fillColor: Color(0xffF5F6F7),
                                       enabledBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                             width: 1, color: Colors.black12),),
                                       hintText: 'First Name',
                                       focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.black)
                                       ),
                                       hintStyle: TextStyle(color: Color(0x9D7D7676))
                                   ),
                                 ),
                               ),
                               const SizedBox(width: 10,),
                               Expanded(
                                 flex: 1,
                                 child: TextField(
                                   controller: lastnameController,
                                   decoration: const InputDecoration(
                                       contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                       filled: true,
                                       fillColor: Color(0xffF5F6F7),
                                       enabledBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                             width: 1, color: Colors.black12),),
                                       hintText: 'Surname',
                                       focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.black)
                                       ),
                                       hintStyle: TextStyle(color: Color(0x9D7D7676))
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           children: [
                             Expanded(
                               child: TextField(
                                 controller: emailController,
                                 keyboardType: TextInputType.emailAddress,
                                 decoration: const InputDecoration(
                                     contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                     filled: true,
                                     fillColor: Color(0xffF5F6F7),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(
                                           width: 1, color: Colors.black12),),
                                     hintText: 'Mobile Number or Email Password',
                                     focusedBorder: OutlineInputBorder(
                                         borderSide: BorderSide(color: Colors.black)
                                     ),
                                     hintStyle: TextStyle(color: Color(0x9D7D7676))
                                 ),
                               ),
                             ),
                           ],
                         ),
                         const SizedBox(
                           height: 10,
                         ),
                         TextFormField(
                           controller: passwordController,
                           obscureText: true,
                           decoration: const InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     width: 1, color: Colors.black12),),
                               contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                               filled: true,
                               fillColor: Color(0xffF5F6F7),
                               hintText: 'Password',
                               focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.black)
                               ),
                               hintStyle: TextStyle(color: Color(0x9D7D7676))
                           ),
                         ),
                         const SizedBox(height: 10),
                         TextFormField(
                           controller: confirmController,
                           obscureText: true,
                           decoration: const InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     width: 1, color: Colors.black12),),
                               contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                               filled: true,
                               fillColor: Color(0xffF5F6F7),
                               hintText: 'Confirm Password',
                               focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.black)
                               ),
                               hintStyle: TextStyle(color: Color(0x9D7D7676))
                           ),
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                         SizedBox(
                           height: 50,
                           width: double.infinity,
                           child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(5),
                                 ),
                                 backgroundColor: Colors.amberAccent,
                               ),
                               onPressed: () async {
                                 var firstname = firstnameController.text.trim();
                                 var lastname = lastnameController.text.trim();


                                 if (firstname.isEmpty ||
                                     lastname.isEmpty ) {
                                   // show error toast

                                   Fluttertoast.showToast(msg: 'Please fill all fields');
                                   return;
                                 }

                                 // request to firebase auth

                                 ProgressDialog progressDialog = ProgressDialog(
                                   context,
                                   title: const  Text('Updating the Detail'),
                                   message: const Text('Please wait'),
                                 );
                                 progressDialog.show();

                                 try {
                                   if (FirebaseAuth.instance.currentUser != null) {

                                     String uid = FirebaseAuth.instance.currentUser!.uid;

                                        await FirebaseFirestore.instance.
                                        collection('users')
                                        .doc(uid)
                                        .update({ 'firstName' : firstname, 'lastName' : lastname   });


                                     Fluttertoast.showToast(msg: 'Success');

                                     Navigator.of(context).pop();

                                   } else {
                                     Fluttertoast.showToast(msg: 'Failed');
                                   }

                                   progressDialog.dismiss();

                                 } on FirebaseAuthException catch (e) {
                                   progressDialog.dismiss();
                                   if (e.code == 'email-already-in-use') {
                                     Fluttertoast.showToast(msg: 'Email is already in Use');
                                   } else if (e.code == 'weak-password') {
                                     Fluttertoast.showToast(msg: 'Password is weak');
                                   }
                                 } catch (e) {
                                   progressDialog.dismiss();
                                   Fluttertoast.showToast(msg: 'Something went wrong');
                                 }
                               },
                               child: const Text('Update Data',style: TextStyle(fontWeight: FontWeight.bold),)),
                         ),

                       ],
                     ),
                   ),
                 ),
               )

                 ],
            ),
          )),
    );
  }
}
