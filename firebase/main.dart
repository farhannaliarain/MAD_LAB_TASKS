
import 'package:leavemanagement/leave_request.dart';
import 'admin_page.dart';
// import 'package:leavemanagement/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leavemanagement/auth_service.dart';
import 'package:leavemanagement/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      routes: {
        '/admin': (context) => LeaveRequestItem(),
        '/leaveR':(context) => LeaveRequestForm(),
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final AuthService authService = AuthService();
  String userId = "";
  signUp() async {
    final User? user = await authService.signUp(
      _emailController.text,
      _passwordController.text,
    );
    await users.add({
      "name": _nameController.text,
      "email": _emailController.text,
    });
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Sign up successful!",
        ),
      ));
    }
  }

  editUser(String id) async {
    await users.doc(id).update(
      {
        "name": _nameController.text,
        "email": _emailController.text,
      },
    );
  }

  deluser(String id) async {
    await users.doc(id).delete();
  }

  signIn() async {
    final User? user = await authService.signIn(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Sign In successful!",
        ),
      ));

    if(_emailController.text=="admin@gmail.com"){
 Navigator.pushNamed(context, '/admin');
    }
    else{
Navigator.pushNamed(context, '/leaveR');
    }

    }
    else { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Sign In not successful!",
        ),
      ));}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Portal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            const SizedBox(
              height: 8,
            ),
            TextField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: "Email",
    filled: true, 
    fillColor: Colors.grey[200], 
    border: OutlineInputBorder( 
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder( 
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  ),
),

SizedBox(
  height: 8,
),

TextField(
  controller: _passwordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: "Password",
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  ),
),
            const SizedBox(
              height: 8,
            ),
           
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: signIn,
              child: const Text("Login"),
            ),
                     ],
        ),
      ),
    );
  }
}

