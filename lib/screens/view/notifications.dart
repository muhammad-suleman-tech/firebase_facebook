import 'package:flutter/material.dart';

import '../../components/customIconButton.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.menu),
                    SizedBox(width: width*0.02,),
                    const Text("Notifications",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  children: [
                    customIconContainer(height: height*0.1,width: width*0.1,icon: Icons.search,),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80",),radius: 35,
                          ),
                          SizedBox(width: width*0.02,),
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Muhammad Umair Hassan ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(text: 'posted a video in ', ),
                                        TextSpan(text: ' Explore Crypto',  style: TextStyle(fontWeight: FontWeight.bold) ),
                                      ],
                                    ),),
                                  Text("10 min ago")
                                ],
                              )
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            height: height*0.07,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.more_horiz)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}


