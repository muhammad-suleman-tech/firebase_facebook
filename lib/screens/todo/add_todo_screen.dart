
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  var taskController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  filled: true,
                  fillColor: Color(0xffF5F6F7),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.black12),),
                  hintText: 'Add Task',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  hintStyle: TextStyle(color: Color(0x9D7D7676))
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: descController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  filled: true,
                  fillColor: Color(0xffF5F6F7),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.black12),),
                  hintText: 'Add Description',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  hintStyle: TextStyle(color: Color(0x9D7D7676))
              ),
            ),

            const SizedBox(height: 10,),

            ElevatedButton(

                onPressed: () async{
              String task = taskController.text.trim();
              String description = descController.text.trim();

              if( task.isEmpty || description.isEmpty){
                Fluttertoast.showToast(msg: 'Please fill task / description');
                return;
              }

              User? user = FirebaseAuth.instance.currentUser;   // getting in instance of current user

              if( user != null ){                // if user login he

                String uid = user.uid;                     // uski unique user id save krlo
                int dt = DateTime.now().millisecondsSinceEpoch;

                // DatabaseReference taskRef = FirebaseDatabase.instance.reference().child('tasks').child(uid);

                FirebaseFirestore firestore = FirebaseFirestore.instance;

                var taskRef = firestore.collection('tasks').doc(uid).collection('tasks').doc();

                await taskRef.set({
                  'dt': dt,
                  'task': task,
                  'description': description,
                  'taskId': taskRef.id,
                }
                );
                Fluttertoast.showToast(backgroundColor: Colors.green, msg: 'Task Added');
                Navigator.of(context).pop();

              }

            }, child: const Text('Save')),

          ],
        ),
      ),
    );  }
}
