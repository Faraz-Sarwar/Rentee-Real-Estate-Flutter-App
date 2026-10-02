import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/components/custom_text_field.dart';
import 'package:rentee_real_estate/view_models/data_vm/user_data_vm.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Widget _infoContainer({required Widget child}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _showAlertDialague(
    String titleText,
    TextEditingController controller,
    onDoneText,
    BuildContext context,
  ) {
    return AlertDialog(
      title: Text(titleText),
      content: CustomTextField(
        controller: controller,
        hintText: "Edit name",
        hideText: false,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('cancel'),
        ),
        TextButton(onPressed: () {}, child: const Text('Change')),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editNameController = TextEditingController();
    final editEmailController = TextEditingController();
    final profileUserInfo = ref.watch(userInfoProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Profie'),
        centerTitle: true,
      ),
      body: profileUserInfo.when(
        data: (data) {
          String name = data?.name != null && data!.name != ""
              ? data.name
              : data!.email.split("@")[0];
          return Padding(
            padding: const EdgeInsets.all(AppSize.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.person_2_outlined,
                      size: 48,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.large),
                _infoContainer(
                  child: ListTile(
                    title: Text(name),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            editNameController.text = name;
                            return _showAlertDialague(
                              'Edit name',
                              editNameController,
                              'Change',
                              context,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.large),
                _infoContainer(
                  child: ListTile(
                    title: Text(data.email),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            editEmailController.text = data.email;
                            return _showAlertDialague(
                              'Edit email',
                              editEmailController,
                              "Change",
                              context,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
