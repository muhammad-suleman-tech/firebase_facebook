import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/screens/signup_screen.dart';
import 'package:firebase_todo_app/screens/todo/todo_screen_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController    = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.purple[50],
      //   title: const Text('Login Please'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/fb.PNG",height: 250,width: double.infinity,fit: BoxFit.fill,),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Form(
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                  filled: true,
                                  fillColor: Color(0xffF5F6F7),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black12),),
                                  hintText: 'Phone Number or Password',
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
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  onPressed: () async {
                                    var email = emailController.text.trim();
                                    var password = passwordController.text.trim();
                                    if (email.isEmpty || password.isEmpty) {
                                      // show error toast
                                      Fluttertoast.showToast(msg: 'Please fill all fields');
                                      return;
                                    }
                                    // request to firebase auth

                                    ProgressDialog progressDialog = ProgressDialog(
                                      context,
                                      title: const Text('Logging In'),
                                      message: const Text('Please wait'),
                                    );

                                    progressDialog.show();

                                    try {
                                      FirebaseAuth auth = FirebaseAuth.instance;

                                      UserCredential userCredential =
                                      await auth.signInWithEmailAndPassword(
                                          email: email, password: password
                                      );
                                      if (userCredential.user != null) {
                                        progressDialog.dismiss();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) {
                                              return const TodoListScreen();
                                            }));
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      progressDialog.dismiss();

                                      if (e.code == 'user-not-found') {
                                        Fluttertoast.showToast(msg: 'User not found');
                                      } else if (e.code == 'wrong-password') {
                                        Fluttertoast.showToast(msg: 'Wrong password');
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: 'Something went wrong');
                                      progressDialog.dismiss();
                                    }
                                  },
                                  child: const Text('Login',style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),)
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text('Forget Password ?',style: TextStyle(color: Colors.blueAccent),)),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("----------------------------------  "),
                                Text(" OR "),
                                Text("  ----------------------------------"),
                              ],
                            ),
                            const SizedBox(height: 20,),
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
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                    );
                                  },
                                  child: const Text("Create new Account",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                              ),
                            )

                          ],
                        ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}