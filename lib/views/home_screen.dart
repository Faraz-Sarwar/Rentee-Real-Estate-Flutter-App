import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';
import 'package:rentee_real_estate/models/user_model.dart';
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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertyProvider);
    final userInfo = ref.watch(userInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: userInfo.when(
          data: (data) {
            return Text(
              "Welcome ${data!.name}",
              style: TextStyle(color: AppColors.textPrimary),
            );
          },
          error: (err, StackTrace) => Text("$err"),
          loading: () => const CircularProgressIndicator(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(authProvider.notifier).logOut();
            },
            icon: const Icon(Icons.logout, color: AppColors.primary),
          ),
        ],
      ),
      body: properties.when(
        data: (data) {
          return Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(data[index].name));
              },
            ),
          );
        },
        error: (err, stack) => Text("Error: $err"),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
