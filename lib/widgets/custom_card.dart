import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color cardColor;

  const CustomCard({super.key, required this.child, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0), // Optional padding for better layout
        child: child,
      ),
    );
  }
}