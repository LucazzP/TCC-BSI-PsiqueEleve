import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/exceptions.dart';
import 'package:psique_eleve/src/core/failures.dart';

Future<Either<Failure, Result>> callEither<Result, Response>(
  Future<Response> Function() request, {
  Future<Either<Failure, Result>> Function(Response res)? processResponse,
  Failure Function(dynamic error)? onError,
}) async {
  assert(
    Response == Result || (!(Response == Result) && processResponse != null),
    'You need to specify the `processResponse` when the types are different',
  );
  processResponse ??= (value) async => Right(value as Result);
  try {
    final response = await request();
    final result = await processResponse(response);
    return result;
  } catch (e) {
    if (e is APITimeoutException || e is APINotConnectedException) {
      return const Left(kConnectionFailure);
    }
    if (e is APIClientNotLoggedException) {
      return const Left(kExpiredSession);
    }
    if (e is APIInvalidLoginCredentialsException) {
      return const Left(kCredentialsFailure);
    }
    if (onError != null) {
      return Left(onError(e));
    }
    return const Left(kServerFailure);
  }
}
