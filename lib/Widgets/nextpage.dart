import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final String notAMember;
  final String inLS;
  const NextPage({super.key, required this.notAMember, required this.inLS});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          notAMember,
          style: TextStyle(color: Colors.grey[700], fontSize: 16,),
        ),
        Text(
          inLS,
          style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        )
      ],
    );
  }
}
