import 'package:flutter/material.dart';
import 'package:forms/success_page.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       //debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHomePage> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  //var name=
  TextEditingController ucontroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  TextEditingController econtroller = TextEditingController();
  String email = "";
  String _selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration Form"),
       backgroundColor: Color.fromARGB(255, 28, 124, 97)),
      body: Container(
        //padding: EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
               TextFormField(
                controller: econtroller,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                //keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }

                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }

                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: ucontroller,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Name!!!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: pcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: dateInput,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateInput.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Select Gender:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: "male",
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value.toString();
                      });
                    },
                  ),
                  Text("Male"),
                  Radio(
                    value: "female",
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value.toString();
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(
                          username: ucontroller.text,
                          password: pcontroller.text,
                          email: econtroller.text,
                          dob: dateInput.text,
                          gender: _selectedGender,
                        ),
                      ),
                    );
                  }
                },
                 style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 18, 159, 133)), // Set the button color
                   ),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
