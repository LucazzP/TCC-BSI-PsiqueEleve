import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';

class LoginEmailParams {
  final String email;
  final String password;

  const LoginEmailParams({
    required this.email,
    required this.password,
  });
}

class LoginEmailUseCase implements BaseUseCase<UserEntity, LoginEmailParams> {
  final AuthRepository _repo;

  const LoginEmailUseCase(this._repo);

  @override
  Future<Either<Failure, UserEntity>> call(LoginEmailParams param) {
    return _repo.loginEmail(email: param.email, password: param.password);
  }
}
