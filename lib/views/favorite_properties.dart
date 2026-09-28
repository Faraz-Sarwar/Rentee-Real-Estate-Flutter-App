import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';

class FavoriteProperties extends StatefulWidget {
  const FavoriteProperties({super.key});

  @override
  State<FavoriteProperties> createState() => _FavoritePropertiesState();
}

class _FavoritePropertiesState extends State<FavoriteProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Favorites'),
        centerTitle: true,
      ),
    );
  }
}
