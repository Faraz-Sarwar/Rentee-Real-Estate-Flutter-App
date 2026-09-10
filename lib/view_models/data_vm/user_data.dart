import 'package:flutter_riverpod/legacy.dart';
import 'package:rentee_real_estate/view_models/data_vm/data_state.dart';

final dataProvider = StateNotifierProvider<UserDataVm, DataState>(
  (ref) => UserDataVm(),
);

class UserDataVm extends StateNotifier<DataState> {
  UserDataVm() : super(DataState());
}
