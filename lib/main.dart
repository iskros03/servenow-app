import 'package:flutter/material.dart';
import 'package:serve_now/screens/home.dart';
import 'package:serve_now/screens/my_profile.dart';
import 'package:serve_now/screens/profile.dart';
import 'package:serve_now/screens/sign_in.dart';
import 'package:serve_now/screens/sign_up.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/sign_in',
      routes: {
        '/home': (context) => const Home(),
        '/sign_in': (context) => const SignIn(),
        '/sign_up': (context) => const SignUp(),
        '/profile': (context) => const Profile(),

        '/my_profile': (context) => const MyProfile()
      }));
}
