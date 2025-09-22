import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
      params.email,
      params.password,
      params.firstName,
      params.lastName,
      params.phone,
      params.userType,
      params.module,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String userType;
  final String module;

  SignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    required this.module,
  });
}
