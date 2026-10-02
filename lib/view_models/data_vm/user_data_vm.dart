import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/models/user_model.dart';
import 'package:rentee_real_estate/repositories/data/data_repo.dart';

final dataProviderVm = Provider<UserDataVm>(
  (ref) => UserDataVm(ref.read(dataRepoProvider)),
);

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

class UserDataVm {
  final DataRepo _dataRepo;
  UserDataVm(this._dataRepo);

  Future<List<PropertyModel>> loadProperties() async {
    try {
      return await _dataRepo.getProperties();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> loadUserInfo(uid) async {
    try {
      return await _dataRepo.getUserInfo(uid);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Set<String>> loadPropertyType() async {
    try {
      return await _dataRepo.getPropertyType();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
