import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeScreenDesign extends StatefulWidget {
  const HomeScreenDesign({super.key});

  @override
  State<HomeScreenDesign> createState() => _HomeScreenDesignState();
}

class _HomeScreenDesignState extends State<HomeScreenDesign> {

  DocumentSnapshot? userSnapshot;

  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(controller.imageGet.value == false) {
      controller.getFirebaseData();
    } else {
   print("wapsi");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.01,vertical: height*0.01),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                   return Expanded(
                     flex: 1,
                     child: CircleAvatar(
                          backgroundImage: controller.imageGet.value
                              ?  NetworkImage(controller.imageFile)
                              : const NetworkImage("https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png")

                      ),
                   );
                  }),
                   // SizedBox(width: width*0.02,),
                  Expanded(
                    flex: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey)
                    ),
                        child: Text("What's on your mind ?",),
                  )),
                  // SizedBox(width: width*0.02,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.photo,color: Colors.green,size: 40,)  )
                ],
              ),
            ),
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: ListView.builder(
                 itemCount: 5,
                  itemBuilder: (context,index){

                  }
              ),
            )
          ],
        ),
      ),
    );
  }


}
