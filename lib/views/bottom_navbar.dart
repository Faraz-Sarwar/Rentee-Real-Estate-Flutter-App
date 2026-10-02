import 'package:flutter/material.dart';
import 'package:rentee_real_estate/components/bottom_navbar.dart';
import 'package:rentee_real_estate/views/appointment_schedule.dart';
import 'package:rentee_real_estate/views/favorite_properties.dart';
import 'package:rentee_real_estate/views/home_screen.dart';
import 'package:rentee_real_estate/views/profile_screen.dart';
import 'package:rentee_real_estate/views/search.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<Widget> screens = const [
    HomeScreen(),
    Search(),
    AppointmentScheduleScreen(),
    FavoriteProperties(),
    ProfileScreen(),
  ];

  int selectedNavbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [screens[selectedNavbarIndex]]),
      bottomNavigationBar: Positioned(
        left: 0,
        right: 0,
        bottom: 20,
        child: FloatingNavbar(
          currentIndex: selectedNavbarIndex,
          onTap: (index) {
            setState(() {
              selectedNavbarIndex = index;
            });
          },
        ),
      ),
    );
  }
}
