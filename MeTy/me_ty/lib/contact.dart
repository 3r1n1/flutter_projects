import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('subject=Pyetje nga përdoruesi&body='),
    );

    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nuk mund të hapet aplikacioni i emailit.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Text("Kontakto Ekspertët"),
        backgroundColor: const Color.fromRGBO(101, 241, 194, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('experts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Asnjë ekspert nuk është i disponueshëm."));
          }

          final experts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: experts.length,
            itemBuilder: (context, index) {
              final expert = experts[index].data() as Map<String, dynamic>;

              final String name = expert['name'] ?? 'Ekspert pa emër';
              final String specialty = expert['specialty'] ?? 'Pa specializim';
              final String? email = expert['email'];
              final String? imageUrl = expert['imageUrl'];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: (imageUrl != null && imageUrl.isNotEmpty)
                        ? Image.network(
                            imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 60, color: Colors.grey);
                            },
                          )
                        : const Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(specialty),
                  trailing: IconButton(
                    icon: const Icon(Icons.email, color: Color.fromRGBO(4, 3, 79, 1)),
                    onPressed: () {
                      if (email != null && email.isNotEmpty) {
                        _launchEmail(email);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Ky ekspert nuk ka adresë emaili.")),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
