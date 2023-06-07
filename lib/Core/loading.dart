import 'package:exptracker/Constant/colors.dart';
import 'package:flutter/material.dart';

class SpinkitPage extends StatelessWidget {
  const SpinkitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: opBlack,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ));
  }
}
