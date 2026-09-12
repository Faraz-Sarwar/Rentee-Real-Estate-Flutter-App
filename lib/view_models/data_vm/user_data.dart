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
    return await _dataRepo.getProperties();
  }

  Future<UserModel> loadUserInfo(uid) async {
    return await _dataRepo.getUserInfo(uid);
  }
}
