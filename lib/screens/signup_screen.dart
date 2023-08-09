
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Join facebook',style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
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
                const SizedBox(
                  height: 10,
                ),
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
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        var firstname = firstnameController.text.trim();
                        var lastname = lastnameController.text.trim();
                        var email = emailController.text.trim();
                        var password = passwordController.text.trim();
                        var confirmPass = confirmController.text.trim();

                        if (firstname.isEmpty ||
                            lastname.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confirmPass.isEmpty) {
                          // show error toast

                          Fluttertoast.showToast(msg: 'Please fill all fields');
                          return;
                        }

                        if (password.length < 6) {
                          // show error toast
                          Fluttertoast.showToast(
                              msg:
                              'Weak Password, at least 6 characters are required');

                          return;
                        }

                        if (password != confirmPass) {
                          // show error toast
                          Fluttertoast.showToast(msg: 'Passwords do not match');

                          return;
                        }
                        // request to firebase auth

                        ProgressDialog progressDialog = ProgressDialog(
                          context,
                          title: const  Text('Creating Account'),
                          message: const Text('Please wait'),
                        );
                        progressDialog.show();

                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          UserCredential userCredential = await auth.createUserWithEmailAndPassword( email: email, password: password);

                          if (userCredential.user != null) {

                            // store user information in Firestore database

                            FirebaseFirestore firestore = FirebaseFirestore.instance;

                            String uid = userCredential.user!.uid;
                            int dt = DateTime.now().millisecondsSinceEpoch;

                         await firestore.collection('users').doc(uid).set({
                              'firstName': firstname,
                              'lastName': lastname,
                              'email': email,
                              'password': password,
                              'uid': uid,
                              'dt': dt,
                              'profileImage': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrQoGh518HulzrSYOTee8UO517D_j6h4AYQ&usqp=CAU'
                            });

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
                      child: const Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),

              ],
            ),
          ),
        ),
      ),
    );  }
}
