

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaveRequestForm extends StatefulWidget {
  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
 CollectionReference db = FirebaseFirestore.instance.collection('employeeReq');
 final auth = FirebaseAuth.instance;  // Add controllers for start date and end date.
  

  

  Future<void> addData(   ) async {

    try {
     
     await db.doc(auth.currentUser!.uid).set({
        "email" : auth.currentUser!.email,
        "requests" : _reasonController.text,
        "isAccepted" : false
     });



    } catch (e){
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Leave Request Portal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Reason for Leave'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a reason';
                  }
                  return null;
                },
              ),
              const SizedBox(
              height: 8,
            ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    setState(() {
                      addData();
                    });
                        
                  }
                },
                child: Text('Submit'),
              ),
              
              StreamBuilder(
      stream: db.doc(auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
          
        }

        
        var userDocument = snapshot.data;
        if (userDocument!.exists) {
        return ListTile(
          title: Text(userDocument!["requests"]),
          trailing: userDocument!["isAccepted"]? Text("approved"): Text("notapproved"),
        );

        } else {

          return Text("not any requests ");
        }
      }
  )
            
               
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
 
  }
}
