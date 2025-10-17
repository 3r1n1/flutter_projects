import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:test_app/forgot.dart';
import 'package:test_app/homepage.dart';
import 'package:test_app/main_navigation.dart';
import 'package:test_app/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? errorMessage;

 signIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    setState(() {
      errorMessage = null;
    });

  
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => const MainNavigation()),
     );

  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = "Email ose fjalëkalim i pasaktë";
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kyçu",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(21, 195, 169, 1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Fjalëkalimi'),
            ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),

            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(() => const Forgot()); // navigate to your login page
                  },
                  child: Text(
                    "Keni harruar fjalëkalimin?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(4, 3, 79, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() => signIn()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(
                  21,
                  195,
                  169,
                  1,
                ), // button color
                foregroundColor: Colors.white, // text (and icon) color
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4, // shadow depth
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text("Kyçu"),
            ),
            SizedBox(height: 30),
             Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      "Nuk keni llogari? ",
      style: TextStyle(fontSize: 14),
    ),
    TextButton(
      onPressed: () {
        Get.to(() => const Signup()); // navigate to signup page
      },
      child: const Text(
        "Krijoni një",
        style: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(4, 3, 79, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)
          ],
        ),
      ),
    );
  }
}
