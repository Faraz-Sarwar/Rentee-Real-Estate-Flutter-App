import 'package:flutter/material.dart';

class ContainerIcon extends StatelessWidget {
  final Icon icon;
  final Color color;
  const ContainerIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: icon,
    );
  }
}
