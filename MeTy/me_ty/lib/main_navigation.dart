import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_ty/homepage.dart';
import 'package:me_ty/posts.dart';
import 'package:me_ty/articles.dart';
import 'package:me_ty/contact.dart';
import 'package:me_ty/login.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const Homepage(),
    const PostsPage(),
    const ArticlesPage(),
    const ContactPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      _logout();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF15C3A9),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ballina"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: "Postimet"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Artikujt"),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: "Kontakt"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Çkyçu"),
        ],
      ),
    );
  }
}
