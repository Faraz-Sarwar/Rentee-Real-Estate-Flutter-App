import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';
import 'package:rentee_real_estate/components/property_details_chip.dart';
import 'package:rentee_real_estate/components/property_info_card.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_vm.dart';
import 'package:rentee_real_estate/view_models/data_vm/user_data.dart';

final propertyProvider = FutureProvider((ref) async {
  return await ref.read(dataProviderVm).loadProperties();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userInfoProvider = FutureProvider.autoDispose((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  return ref.read(dataProviderVm).loadUserInfo(user.uid);
});

final propertyTypeProvider = FutureProvider((ref) async {
  return await ref.read(dataProviderVm).loadPropertyType();
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final searchController = TextEditingController();
  String searchQuery = "";
  int selectedIndex = -1;

  void onChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertyProvider);
    final userInfo = ref.watch(userInfoProvider);
    final propertyType = ref.watch(propertyTypeProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.medium,
            vertical: AppSize.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userInfo.when(
                    data: (data) => Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome ",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextSpan(
                            text: '${data!.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    error: (err, StackTrace) => Text(err.toString()),
                    loading: () => const Text('Loading username...'),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await ref.read(authVmProvider.notifier).logOut();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.043,
                      width: MediaQuery.of(context).size.width * 0.095,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primary,
                      ),
                      child: const Icon(Icons.logout, color: AppColors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.medium),
              const Text(
                'Search your House\nby Rentee',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppSize.large),
              CustomTextField(
                controller: searchController,
                hintText: 'Search your dream house',
                hideText: false,
                icon: Icons.search,
                onChanged: onChanged,
              ),
              const SizedBox(height: AppSize.medium),
              propertyType.when(
                data: (data) => SizedBox(
                  height: 46,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = -1;
                        }),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.125,

                          width: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                            color: selectedIndex == -1
                                ? AppColors.primary
                                : null,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: AppColors.textMuted),
                          ),
                          child: Center(
                            child: Text(
                              'All',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == -1
                                    ? AppColors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final type = data.elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.small,
                              ),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  selectedIndex = index;
                                }),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.125,

                                  width:
                                      MediaQuery.of(context).size.width * 0.225,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? AppColors.primary
                                        : null,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: selectedIndex == index
                                            ? AppColors.white
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                error: (err, StackTrace) => Text('$err'),
                loading: () => Center(child: const CircularProgressIndicator()),
              ),
              const SizedBox(height: AppSize.large),
              const Text(
                'Properties for you',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppSize.medium),
              selectedIndex > -1
                  ? properties.when(
                      data: (data) {
                        final selectedType = propertyType.value != null
                            ? propertyType.value!.elementAt(selectedIndex)
                            : null;

                        final filteredProperties = selectedType == null
                            ? <PropertyModel>[]
                            : data
                                  .where((p) => p.propertyType == selectedType)
                                  .toList();
                        return Expanded(
                          child: ListView.builder(
                            itemCount: filteredProperties.length,
                            itemBuilder: (context, index) {
                              final property = filteredProperties[index];

                              return PropertyInfoCard(property: property);
                              // return Container(
                              //   height:
                              //       MediaQuery.of(context).size.height * 0.35,
                              //   margin: EdgeInsets.symmetric(
                              //     vertical: AppSize.medium,
                              //   ),
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: AppColors.white,
                              //     borderRadius: BorderRadius.circular(24),
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       ClipRRect(
                              //         borderRadius: BorderRadius.circular(20),
                              //         child: Image.network(
                              //           property.imageUrl,
                              //           height: 200,
                              //           fit: BoxFit.cover,
                              //           width: double.infinity,
                              //           errorBuilder:
                              //               (context, error, stackTrace) =>
                              //                   Container(
                              //                     height: 200,
                              //                     color: Colors.grey[300],
                              //                     child: const Icon(
                              //                       Icons.broken_image,
                              //                     ),
                              //                   ),
                              //         ),
                              //       ),
                              //       const SizedBox(height: AppSize.small),
                              //       Padding(
                              //         padding: const EdgeInsets.all(
                              //           AppSize.medium,
                              //         ),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   property.name,
                              //                   style: TextStyle(
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //                 Text(
                              //                   '\$${property.price.toString()}/m',
                              //                   style: TextStyle(
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             const SizedBox(height: AppSize.small),
                              //             // Container(
                              //             //   decoration: BoxDecoration(
                              //             //     color: AppColors.background,
                              //             //     borderRadius:
                              //             //         BorderRadius.circular(12),
                              //             //   ),
                              //             //   // (.split) breaks the string into List
                              //             //   // based on some pattern defined
                              //             //   // "Hello, Hi" becomes [Hello, Hi]
                              //             //   // I used .split to // Get (city) location from
                              //             //   // the full location ({city + State})
                              //             //   // Eg (Denver, Colorado,) => Denver
                              //             //   // Eg (Seattle Washington) => Seattle
                              //             //   child: Center(
                              //             //     child: Text(
                              //             //       property.location
                              //             //           .split(',')[0]
                              //             //           .toString(),
                              //             //     ),
                              //             //   ),
                              //             // ),
                              //             Row(
                              //               children: [
                              //                 PropertyDetailsChip(
                              //                   property: property,
                              //                   icon:
                              //                       Icons.location_on_outlined,
                              //                   text: property.location
                              //                       .split(',')[0]
                              //                       .toString(),
                              //                 ),
                              //                 const SizedBox(
                              //                   width: AppSize.small,
                              //                 ),
                              //                 PropertyDetailsChip(
                              //                   property: property,
                              //                   icon: Icons.star_border,
                              //                   text: property.rating
                              //                       .toString(),
                              //                 ),
                              //                 const SizedBox(
                              //                   width: AppSize.small,
                              //                 ),
                              //                 PropertyDetailsChip(
                              //                   property: property,
                              //                   icon: Icons.bed_rounded,
                              //                   text:
                              //                       '${property.bedrooms.toString()} Bed',
                              //                 ),
                              //                 const SizedBox(
                              //                   width: AppSize.small,
                              //                 ),
                              //                 PropertyDetailsChip(
                              //                   property: property,
                              //                   icon: Icons.shower,
                              //                   text:
                              //                       '${property.bedrooms.toString()} Bath',
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                          ),
                        );
                      },
                      error: (err, StackTrace) =>
                          Center(child: Text(err.toString())),
                      loading: () => const CircularProgressIndicator(),
                    )
                  : properties.when(
                      data: (data) {
                        final filteredProperties = searchQuery.isEmpty
                            ? data
                            : data
                                  .where(
                                    (p) => p.name.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    ),
                                  )
                                  .toList();
                        return Expanded(
                          child: ListView.builder(
                            itemCount: filteredProperties.length,
                            itemBuilder: (context, index) {
                              final PropertyModel property =
                                  filteredProperties[index];
                              return PropertyInfoCard(property: property);
                            },
                          ),
                        );
                      },
                      error: (err, StackTrace) =>
                          Center(child: Text('${err.toString}')),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
