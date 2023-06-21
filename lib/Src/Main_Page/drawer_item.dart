import 'package:exptracker/Constant/colors.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final dynamic icon;

  const DrawerItem({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: opBlack,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
