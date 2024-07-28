import 'package:flutter/material.dart';
import 'package:pingolearn/features/auth/domain/usecases/user_login.dart';

enum AuthState {
  initial,
  loading,
  success,
  failure,
}

class LoginProvider extends ChangeNotifier {
  final UserLogin userLogin;
  LoginProvider(this.userLogin);

  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<void> authLogin({
    required String email,
    required String password,
  }) async {
    _state = AuthState.loading;
    notifyListeners();

    final res = await userLogin(
      UserLoginParams(email: email, password: password),
    );

    res.fold(
      (l) {
        _state = AuthState.failure;
        _errorMessage = l.message;
      },
      (r) {
        _state = AuthState.success;
        _successMessage = r;
      },
    );
    notifyListeners();
  }
}
