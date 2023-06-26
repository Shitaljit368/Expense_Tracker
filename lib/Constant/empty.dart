import 'package:exptracker/Constant/colors.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: white,
          height: 300,
          width: 300,
          child: Image.asset("assests/images/empty.jpg",height: 150,)),
      ),
    );
  }
}