import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.medium),
          child: CustomTextField(
            controller: searchController,
            hintText: 'Search property',
            hideText: false,
            icon: Icons.search,
          ),
        ),
      ),
    );
  }
}
