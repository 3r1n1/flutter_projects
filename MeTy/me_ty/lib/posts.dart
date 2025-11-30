import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:me_ty/PostDetailPage.dart';
import 'package:me_ty/new_post.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  Future<void> addPost() async {
    Get.to(() => const NewPostPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Komuniteti'),
      backgroundColor: const Color.fromRGBO(101, 241, 194, 1),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!.docs;

          if (posts.isEmpty) {
            return const Center(child: Text('Nuk ka postime ende.'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(post['title'] ?? ''),
                  subtitle: Text(post['content'] ?? ''),
                  trailing: Text(post['authorName'] ?? 'Anonim'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(
                          postId: posts[index].id,
                          title: post['title'],
                          content: post['content'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPost,
        backgroundColor: const Color.fromRGBO(21, 195, 169, 1),
        child: const Icon(Icons.add),
      ),
      
    );
  }

  
      
    
  }

