
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("hallo App"),
      ),
      body: const Column(
        children: [
          Text("hallo App"),
        ],
      )
    );
  }
}
