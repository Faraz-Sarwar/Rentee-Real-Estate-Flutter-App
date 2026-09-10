import 'package:flutter_riverpod/legacy.dart';
import 'package:rentee_real_estate/repositories/auth/auth_repo.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_state.dart';

final authProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepo _repo = AuthRepo();
  AuthViewModel() : super(AuthState());

  Future<void> login(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      await _repo.loginWithEmailAndPasswrod(email, password);
      state = AuthState(isLoading: false);
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
    }
  }

  Future<void> SignUp(String userName, String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      await _repo.signUpWithEmailAndPassword(userName, email, password);
      state = AuthState(isLoading: false);
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
    }
  }

  Future<void> logOut() async {
    await _repo.logOut();
  }
}
