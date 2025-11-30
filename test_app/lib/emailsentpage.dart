import 'package:flutter/material.dart';
import 'package:test_app/login.dart';
import 'package:test_app/forgot.dart';

class EmailSentPage extends StatelessWidget {
  const EmailSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email Sent")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "Një email për rivendosjen e fjalëkalimit është dërguar.\nJu lutemi kontrolloni kutinë tuaj hyrëse dhe dosjen e spamit.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
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
             
            
              child: const Text("Vazhdo të kyçesh"
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Forgot()),
                );
              },
              child: const Text("Ndërro Email-in"),
            ),
          ],
        ),
      ),
    );
  }
}
