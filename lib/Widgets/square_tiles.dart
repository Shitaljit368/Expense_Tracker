import 'package:flutter/material.dart';

class SquareTiles extends StatelessWidget {
  final String imagepath;
  const SquareTiles({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagepath,
              height: 30,
              width: 30,
            ),
            const Text(
              "  Sign in with Google",
              style: TextStyle(fontSize: 16, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
