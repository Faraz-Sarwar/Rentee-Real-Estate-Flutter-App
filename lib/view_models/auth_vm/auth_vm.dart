import 'package:flutter_riverpod/legacy.dart';
import 'package:rentee_real_estate/repositories/auth/auth_repo.dart';
import 'package:rentee_real_estate/view_models/auth_vm/auth_state.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepo _repo = AuthRepo();
  AuthViewModel() : super(AuthState());

  Future<bool> login(String email, String password) async {
    AuthState(isLoading: true);
    try {
      await _repo.loginWithEmailAndPasswrod(email, password);
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    } finally {
      state = AuthState(isLoading: false);
    }
  }

  Future<bool> SignUp(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      await _repo.signUpWithEmailAndPassword(email, password);
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    } finally {
      state = AuthState(isLoading: false);
    }
  }
}
