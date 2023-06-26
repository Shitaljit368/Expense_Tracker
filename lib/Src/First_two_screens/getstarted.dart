import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      PageView(
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Lets's Get Started.",
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Easiest way to track your daily ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "expense and income.",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Lets's Get Started",
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Easiest way to track your expenses",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 108, 52, 220),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Lets's Get Started",
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Easiest way to track your expenses",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
