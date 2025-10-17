import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/contact.dart';
import 'package:test_app/homepage.dart';
import 'package:test_app/login.dart';
import 'package:test_app/posts.dart';
import 'package:test_app/new_post.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // List of the main app pages (excluding logout)
  final List<Widget> _pages = [
    const Homepage(),
    const PostsPage(),
    const ContactPage(),
  ];

  void _onItemTapped(int index) async {
    if (index == 3) {
      // 🟢 Log out when user taps "Çkyçu"
      await FirebaseAuth.instance.signOut();

      // Replace current route stack with Login
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false, // remove all previous routes
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromRGBO(21, 195, 169, 1),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ballina'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Komuniteti'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Kontakto'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Çkyçu'),
        ],
      ),
    );
  }
}
