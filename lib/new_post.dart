import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/homepage.dart';
import 'package:test_app/posts.dart';
import 'package:get/get.dart';
import 'package:test_app/main_navigation.dart';


class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}
Future<void> gohome() async {
    Get.offAll(() => const MainNavigation());
  }
class _NewPostPageState extends State<NewPostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Future<void> _submitPost() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You must be logged in to post.')),
    );
    return;
  }

  try {
    await FirebaseFirestore.instance.collection('posts').add({
      'title': _titleController.text.trim(),
      'content': _contentController.text.trim(),
      'authorId': user.uid,
      'authorName': user.displayName ?? user.email ?? 'Anonymous',
      'timestamp': FieldValue.serverTimestamp(),
    });
   
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('U postua me sukses!')),
    );
  Get.offAll(() => const MainNavigation(initialIndex: 1));
    _titleController.clear();
    _contentController.clear();
  } catch (e) {
    print('❌ Error adding post: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Krijo një postim')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titulli i postimit tuaj'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Përmbajtja'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPost,
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
              child: const Text('Posto'),
              
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gohome,
        child: const Icon(Icons.home),
      ),
    );
  }
}
