

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LeaveRequest {
  final String name;
  final String reason;

  LeaveRequest(this.name, this.reason);
}




class LeaveRequestItem extends StatefulWidget {



 

  @override
  State<LeaveRequestItem> createState() => _LeaveRequestItemState();
}

class _LeaveRequestItemState extends State<LeaveRequestItem> {
  CollectionReference db = FirebaseFirestore.instance.collection('employeeReq');
 final auth = FirebaseAuth.instance; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Portal"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
            stream: db.snapshots(),
            builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            }
            
             return ListView(
            children: snapshot.data!.docs.map((document) {
              return Center(
                child: Container(
                  color: Colors.amber,
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 6,
                  child:Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Email: ${document["email"]}"),
                      SizedBox(height: 10,),
                      Text("Request: ${document["requests"]}"),
                      SizedBox(height: 10,),
                      document["isAccepted"]? ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[600])
            ),
            onPressed: (){},
          child: Text("approved")) : ElevatedButton(
             style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)
            ),
            onPressed: (){

               db.doc(document.id).update({
                 "isAccepted" : true
               });

            },
          child: Text("approve")),
          
                    ],
                    
                  ),
        //           child: 
                  
                  
                  
        //             ListTile(
        //   title: Text(document["requests"]),
        //   subtitle: Text(document["email"]),
        //   trailing: document["isAccepted"]? ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(Colors.grey[600])
        //     ),
        //     onPressed: (){},
        //   child: Text("approved")) : ElevatedButton(
        //      style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(Colors.green)
        //     ),
        //     onPressed: (){

        //        db.doc(document.id).update({
        //          "isAccepted" : true
        //        });

        //     },
        //   child: Text("approve")),
        // )
                  
                  
                  
                  
                  
                ),
              );
            }).toList(),
            );
            }
            ),
          ),
        ],
      ),
    );
  }
}
// StreamBuilder<QuerySnapshot>(
//               stream: users.snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const CircularProgressIndicator();
//                 }
//                 final userList = snapshot.data!.docs;
//                 return Expanded(
//                   child: ListView.builder(
//                       itemCount: userList.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(userList[index]["name"]),
//                           subtitle: Text(userList[index]["email"]),
//                           trailing:
//                               Row(mainAxisSize: MainAxisSize.min, children: [
//                             IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   // _nameController.text =
//                                       // userList[index]["name"];
//                                   _emailController.text =
//                                       userList[index]["email"];
//                                   userId = userList[index].id;
//                                 });
//                               },
//                               icon: const Icon(Icons.edit),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 deluser(userList[index].id);
//                               },
//                               icon: Icon(Icons.delete),
//                             ),
//                           ]),
//                         );
//                       }),
//                 );
//               },
//             )




//  ListTile(
//       title: Text(leaveRequest.name),
//       subtitle: Text(leaveRequest.reason),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: Icon(Icons.check, color: Colors.green),
//             onPressed: () {
//               // Handle "Approved" action here
//               // You can implement logic to approve the leave request
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.close, color: Colors.red),
//             onPressed: () {
//               // Handle "Reject" action here
//               // You can implement logic to reject the leave request
//             },
//           ),
//         ],
//       ),
//     );