import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateTaskScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const UpdateTaskScreen({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {

  var taskController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    taskController.text = widget.documentSnapshot['task'];
    descController.text = widget.documentSnapshot['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(hintText: 'Task Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var taskName = taskController.text.trim();
                  var descName = descController.text.trim();
                  if (taskName.isEmpty || descName.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please provide task name');
                    return;
                  }

                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(uid)
                      .collection('tasks')
                      .doc(widget.documentSnapshot['taskId'])
                      .update({'task': taskName,'description':descName});

                  Fluttertoast.showToast(msg: 'Task Updated');
                  Navigator.of(context).pop();

                },
                child: const Text('Update')),
          ],
        ),
      ),
    );
  }
}