import 'package:flutter/material.dart';
import 'package:serve_now/screens/dashboard.dart';
import 'package:serve_now/screens/profile.dart';
import 'package:serve_now/screens/settings.dart';
import 'package:serve_now/widgets/custom_bot_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Profile(),
          Dashboard(),
          Settings()
        ],
      ),
      bottomNavigationBar: CustomBotNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
