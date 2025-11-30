import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_ty/forgot.dart';
import 'package:me_ty/homepage.dart';
import 'package:me_ty/main_navigation.dart';
import 'package:me_ty/signup.dart';

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
      backgroundColor: Color(0xFFfffffff),
      appBar: AppBar(
        title: const Text(
          "Kyçu",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(101, 241, 194, 1),
          ),
          
          
        ),
         centerTitle: true,
         backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // ---------------------
            //        APP LOGO
            // ---------------------
            Center(
              child: Image.asset(
                "assets/icon/MeTy.png", // <- make sure this exists in your assets folder!
                height: 120,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Fjalëkalimi'),
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
                    Get.to(() => const Forgot());
                  },
                  child: const Text(
                    "Keni harruar fjalëkalimin?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(25, 102, 255, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => signIn(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(101, 241, 194, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Kyçu"),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nuk keni llogari? ",
                  style: TextStyle(fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const Signup());
                  },
                  child: const Text(
                    "Krijoni një",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(25, 102, 255, 1),
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
