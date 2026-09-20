import 'package:flutter/material.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/components/property_details_chip.dart';
import 'package:rentee_real_estate/models/property_model.dart';

class PropertyInfoCard extends StatelessWidget {
  final PropertyModel property;
  const PropertyInfoCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      margin: EdgeInsets.symmetric(vertical: AppSize.medium),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              property.imageUrl,
              height: 200,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
          const SizedBox(height: AppSize.small),
          Padding(
            padding: const EdgeInsets.all(AppSize.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${property.price.toString()}/m',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.small),
                // Container(
                //   decoration: BoxDecoration(
                //     color: AppColors.background,
                //     borderRadius:
                //         BorderRadius.circular(12),
                //   ),
                //   // (.split) breaks the string into List
                //   // based on some pattern defined
                //   // "Hello, Hi" becomes [Hello, Hi]
                //   // I used .split to // Get (city) location from
                //   // the full location ({city + State})
                //   // Eg (Denver, Colorado,) => Denver
                //   // Eg (Seattle Washington) => Seattle
                //   child: Center(
                //     child: Text(
                //       property.location
                //           .split(',')[0]
                //           .toString(),
                //     ),
                //   ),
                // ),
                Row(
                  children: [
                    PropertyDetailsChip(
                      icon: Icons.location_on_outlined,
                      text: property.location.split(',')[0].toString(),
                    ),
                    const SizedBox(width: AppSize.small),
                    PropertyDetailsChip(
                      icon: Icons.star_border,
                      text: property.rating.toString(),
                    ),
                    const SizedBox(width: AppSize.small),
                    PropertyDetailsChip(
                      icon: Icons.bed_rounded,
                      text: '${property.bedrooms.toString()} Bed',
                    ),
                    const SizedBox(width: AppSize.small),
                    PropertyDetailsChip(
                      icon: Icons.shower,
                      text: '${property.bedrooms.toString()} Bath',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
