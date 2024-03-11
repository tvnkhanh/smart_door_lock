import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardMenu extends StatelessWidget {
  final String title;
  final String icon;
  VoidCallback? onTap;
  Color? color = Colors.white;
  Color? fontColor = Colors.grey;

  CardMenu({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 36,
        ),
        width: 156,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.asset(icon),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
