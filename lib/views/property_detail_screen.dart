import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/components/container_icon.dart';
import 'package:rentee_real_estate/components/property_details_chip.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/views/schedule_visit_screen.dart';

class PropertyDetailScreen extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetailScreen({super.key, required this.property});

  // Property Information container
  Widget _infoContainer({
    required BuildContext context,
    required IconData icon,
    required String mainText,
    String? secondaryText,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: AppSize.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: AppSize.medium),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "$mainText\n",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextSpan(text: secondaryText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Property Image
            Image.network(
              property.imageUrl,
              height: screenHeight * 0.5,
              width: double.infinity,
              fit: BoxFit.fill,
            ),

            // Back and Favorite buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSize.medium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: ContainerIcon(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        color: AppColors.white,
                      ),
                    ),
                    ContainerIcon(
                      icon: const Icon(Icons.favorite_border_rounded),

                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),

            // Details Card floating with image, I like this kind of look.
            Positioned(
              top: screenHeight * 0.45,
              left: 0,
              right: 0,
              child: Container(
                constraints: BoxConstraints(minHeight: screenHeight * 0.57),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.large,
                    vertical: AppSize.vLarge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            property.price.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.medium),
                      Text(
                        property.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: AppSize.large),
                      Row(
                        children: [
                          PropertyDetailsChip(
                            icon: Icons.location_on_outlined,
                            text: property.location.split(',')[0],
                          ),
                          const SizedBox(width: AppSize.large),
                          PropertyDetailsChip(
                            icon: Icons.local_parking,
                            text: property.parking ? "Parking" : "No parking",
                          ),
                          const SizedBox(width: AppSize.large),
                          PropertyDetailsChip(
                            icon: Icons.maps_home_work_outlined,
                            text: property.propertyType,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.large),
                      Row(
                        children: [
                          _infoContainer(
                            context: context,
                            icon: Icons.area_chart_outlined,
                            mainText: "${property.area.toString()} sqft",
                            secondaryText: "Area",
                          ),
                          const SizedBox(width: AppSize.small),
                          _infoContainer(
                            context: context,
                            icon: Icons.bed_rounded,
                            mainText: "${property.bedrooms.toString()} rooms",
                            secondaryText:
                                "${property.bathrooms.toString()} baths",
                          ),
                          const SizedBox(width: AppSize.small),
                          _infoContainer(
                            context: context,
                            icon: Icons.house_outlined,
                            mainText: property.propertyType,
                            secondaryText: "Type",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSize.medium),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffB88CFF), // lighter top
                Color(0xff7B3FE4),
              ],
            ),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ScheduleVisitScreen(property: property),
                ),
              ),
              child: Text(
                'Schedule a Visit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
