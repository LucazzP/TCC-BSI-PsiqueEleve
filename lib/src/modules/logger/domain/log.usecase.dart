import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';

class LogUseCase implements BaseUseCase<void, String> {
  const LogUseCase();

  @override
  Future<Either<Failure, void>> call(String message) async {
    log(message);
    return const Right(null);
  }
}
