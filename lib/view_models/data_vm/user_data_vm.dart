import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/models/user_model.dart';
import 'package:rentee_real_estate/repositories/data/data_repo.dart';

final dataProviderVm = Provider<UserDataVm>(
  (ref) => UserDataVm(ref.read(dataRepoProvider)),
);

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
