import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/login.dart';
import 'package:test_app/wrapper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // for formatting Date of Birth
import 'package:cloud_firestore/cloud_firestore.dart'; // add this
import 'main_navigation.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController dob = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user in Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email.text.trim(),
              password: password.text.trim(),
            );

        // Save extra data in Firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
              "name": name.text.trim(),
              "email": email.text.trim(),
              "dob": dob.text.trim(), // stored as string 'yyyy-MM-dd'
              "createdAt": FieldValue.serverTimestamp(),
            });

        Get.offAll(() => const MainNavigation());

      } catch (e) {
        print("Signup error: $e");
        Get.snackbar("Error", e.toString());
      }
    }
  }

  // Check age
  bool is18orOlder(String dobText) {
    try {
      final DateTime birthDate = DateFormat("yyyy-MM-dd").parse(dobText);
      final DateTime today = DateTime.now();
      final int age = today.year - birthDate.year;
      final int month1 = today.month;
      final int month2 = birthDate.month;

      if (month2 > month1 || (month1 == month2 && birthDate.day > today.day)) {
        return age - 1 >= 18;
      }
      return age >= 18;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Krijo një llogari",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(21, 195, 169, 1),
                ),
              ),
                Row(
                  children: [
                    Text(
                      "Ke një llogari? ",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          () => const Login(),
                        ); // navigate to your login page
                      },
                      child: Text(
                        "Kliko këtu",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF04034f),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            
              TextFormField(
                controller: name,
                decoration: InputDecoration(hintText: 'Emri dhe Mbiemri'),
                validator: (value) =>
                    value!.isEmpty ? "Shkruaj emrin dhe mbiemrin" : null,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) => value!.isEmpty ? "Shkruaj emailin" : null,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Fjalëkalimi'),
                validator: (value) => value!.length < 6
                    ? "Fjalëkalimi duhet të ketë së paku 6 karaktere"
                    : null,
              ),
              TextFormField(
                controller: confirmPassword,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Konfirmo fjalëkalimin'),
                validator: (value) => value != password.text
                    ? "Fjalëkalimet nuk janë të njëjta"
                    : null,
              ),
              TextFormField(
                controller: dob,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Datëlindja',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat(
                      'yyyy-MM-dd',
                    ).format(pickedDate);
                    setState(() {
                      dob.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty){
                    return "Ju lutem zgjidhni datëlindjen tuaj";
                  }
                  if (!is18orOlder(value)) {
                    return "Ju duhet të jeni së paku 18 vjeç";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: signup,style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(4, 3, 79, 1), // button color
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
              ), child: Text("Regjistrohu")),
            ]
          ),
        ),
      ));
  
  }}
