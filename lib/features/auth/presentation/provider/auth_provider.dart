import 'package:flutter/material.dart';
import 'package:pingolearn/features/auth/domain/usecases/user_signup.dart';

enum AuthState {
  initial,
  loading,
  success,
  failure,
}

class AuthentProvider extends ChangeNotifier {
  final UserSignUp userSignUp;
  AuthentProvider(this.userSignUp);

  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<void> authSignUp(
      {required String name,
      required String email,
      required String password}) async {
    _state = AuthState.loading;
    notifyListeners();

    final res = await userSignUp(
        UserSignUpParams(name: name, email: email, password: password));

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
