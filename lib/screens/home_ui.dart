import 'package:firebase_todo_app/components/customIconButton.dart';
import 'package:firebase_todo_app/screens/home_screen.dart';
import 'package:firebase_todo_app/screens/todo/todo_screen_list.dart';
import 'package:firebase_todo_app/screens/view/notifications.dart';
import 'package:flutter/material.dart';

class HomeScreenUI extends StatefulWidget {
  const HomeScreenUI({super.key});

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/app_logo.png",fit: BoxFit.fill,height:height*0.08 ),
      actions: [
        customIconContainer(height: height*0.1,width: width*0.1,icon: Icons.add,),
        SizedBox(width: width*0.02,),
        customIconContainer(height: height*0.1,width: width*0.1,icon: Icons.search,),
        SizedBox(width: width*0.02,),
        Container( margin: EdgeInsets.only(right: width*0.03), child: customIconContainer(height: height*0.1,width: width*0.1,icon: Icons.message,)),
      ],
      ),
      body: DefaultTabController(
          length: 6,
          child: Column(
        children: [
          SizedBox(
            width: width,
            height: height*0.05,
            child: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Icon(Icons.home_outlined,size: 30,),
                  Icon(Icons.group_add_outlined,size: 30,),
                  Icon(Icons.ondemand_video,size: 30,),
                  Icon(Icons.house_outlined,size: 30,),
                  Icon(Icons.notification_add_outlined,size: 30),
                  Icon(Icons.menu,size: 30,)
            ]
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                HomeScreenDesign(),
                TaskListScreen(),
                Text("home"),
                Text("home"),
                NotificationsScreen(),
                Text("home"),
              ],
            ),
          )
        ],
      )),

    );
  }
}
