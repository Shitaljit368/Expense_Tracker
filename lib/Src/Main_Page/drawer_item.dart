import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final dynamic icon;
  final onpressed;
  const DrawerItem({
    super.key,
    required this.name,
    required this.icon, this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            size: 35,
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
