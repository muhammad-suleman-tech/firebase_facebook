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
              automaticallyImplyLeading: false,
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
                        child: const Text("What's on your mind ?",),
                  )),
                  // SizedBox(width: width*0.02,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.photo,color: Colors.green,size: 40,)  )
                ],
              ),
            ),
            SliverAppBar(
              pinned: false,
              expandedHeight: height*0.30,
              backgroundColor: Colors.transparent,
              flexibleSpace: ListView.builder(
                 itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    if(index == 0 ){
                      return Container(
                        margin: const EdgeInsets.all(5),
                        alignment: Alignment.bottomCenter,
                        height: height*0.25,
                        width: width*0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image:  controller.imageGet.value ?   NetworkImage(controller.imageFile) : const NetworkImage("https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Ym9va3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80")  )
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: height*0.1,
                              width: width*0.3,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(height: height*0.01,),
                                Expanded(
                                  child: CircleAvatar(
                                    radius: height*0.02,
                                    backgroundColor: Colors.blueAccent,
                                    child: const Icon(Icons.add,color: Colors.white,),
                                  ),
                                ),
                                SizedBox(height: height*0.01,),
                                const Expanded(child: Text("Create Story"))
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.all(8),
                        height: height*0.30,
                        width: width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          image: const DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Ym9va3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),fit: BoxFit.cover),
                        ),
                        child: const Text("Hamza Khan",style: TextStyle(color: Colors.white),),
                      );
                    }
                  }
              ),
            ),

            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context, index){
              return Column(
                children: [
                  ListTile(
                    contentPadding : EdgeInsets.zero,
                    title: const Text("Hamza Khan"),
                    leading: const CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80"),radius: 17,),
                    subtitle: const Text("2 hr ago"),
                    trailing: SizedBox(
                      height: height*0.1,
                      width : width*0.2,
                      child: Row(
                        children: [
                          const Icon(Icons.more_horiz),
                          SizedBox(width: width*0.04,),
                          const Icon(Icons.cancel_outlined)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset("assets/images/lion.jpg"),
                  ),
                  SizedBox(height: height*0.02,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.thumb_up,color: Colors.blueAccent,), Icon(Icons.emoji_emotions_sharp,color: Colors.amberAccent,),Text("473")
                          ],
                        ),
                        Row(
                          children: [
                            Text("9"), Text("comments"),Text(" . "),Text("345"),Text("shares"),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.thumb_up_alt_outlined), SizedBox(width: width*0.02,), const Text("Like")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.comment_bank),SizedBox(width: width*0.02,),const Text("Comments")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.send),SizedBox(width: width*0.02,),const Text("Share")
                        ],
                      ),
                    ],
                  )

                ],
              );
            } ))


          ],
        ),
      ),
    );
  }


}

