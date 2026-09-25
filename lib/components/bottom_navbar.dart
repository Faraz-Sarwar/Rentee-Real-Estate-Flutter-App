import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';

class FloatingNavbar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final activeColor;
  final inActiveColor;
  final backgroundColor;

  const FloatingNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = AppColors.primary,
    this.inActiveColor = AppColors.background,
    this.backgroundColor = AppColors.white,
  });

  @override
  State<FloatingNavbar> createState() => _FloatingNavbarState();
}

class _FloatingNavbarState extends State<FloatingNavbar> {
  final List _icons = const [
    Icons.home,
    Icons.search,
    Icons.schedule,
    Icons.person_2_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.large),
      child: Container(
        height: 74,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (int index) {
            final bool isActive = widget.currentIndex == index;
            return GestureDetector(
              onTap: () => widget.onTap(index),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.small),
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 200),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: isActive ? widget.activeColor : widget.inActiveColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    _icons[index],
                    color: isActive ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
