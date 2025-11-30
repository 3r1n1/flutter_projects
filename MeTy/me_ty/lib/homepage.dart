import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? user?.email?.split('@')[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Greeting
              Text(
                userName == null ? 'Përshëndetje 👋' : 'Përshëndetje, $userName 👋',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Welcome description
              const Text(
                "Mirë se vini në aplikacionin tonë! Ne ofrojmë informacion të fundit, një komunitet për diskutime, dhe lidhje me specialistë për çdo nevojë tuajën.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Main image
              Center(
                child: Image.asset(
                  'assets/icon/MeTy.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),

              // Features heading
              const Text(
                "Çfarë mund të bëni në aplikacionin tonë:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Feature cards
              _featureCard(
                icon: Icons.forum,
                title: "Komuniteti",
                description: "Shiko dhe postoni në komunitetin tonë aktiv për të ndarë ide dhe përvojë.",
              ),
              const SizedBox(height: 12),
              _featureCard(
                icon: Icons.article,
                title: "Artikuj & Lajme",
                description: "Lexoni artikuj dhe lajme të fundit për të qëndruar të informuar.",
              ),
              const SizedBox(height: 12),
              _featureCard(
                icon: Icons.contact_mail,
                title: "Kontakto Specialistë",
                description: "Gjeni ekspertë dhe caktoni takime për udhëzim të personalizuar.",
              ),
              const SizedBox(height: 24),

              // Final "powered by" sentence
              const Text(
                "Powered by KED Innovation Center – A platform for community, knowledge, and expert guidance.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Feature card widget (informational only)
Widget _featureCard({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent.withOpacity(0.15),
          ),
          child: Icon(icon, size: 30, color: Colors.blueAccent),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
