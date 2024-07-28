import 'package:fpdart/fpdart.dart';
import 'package:pingolearn/core/error/failures.dart';
import 'package:pingolearn/core/usecase/usecase.dart';
import 'package:pingolearn/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<String, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({
    required this.email,
    required this.password,
  });
}
