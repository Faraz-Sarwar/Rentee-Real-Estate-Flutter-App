import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';

class PropertyDetailsChip extends StatelessWidget {
  final String text;
  final IconData icon;
  const PropertyDetailsChip({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      // (.split) breaks the string into List
      // based on some pattern defined
      // "Hello, Hi" becomes [Hello, Hi]
      // I used .split to // Get (city) location from
      // the full location ({city + State})
      // Eg (Denver, Colorado,) => Denver
      // Eg (Seattle Washington) => Seattle
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
