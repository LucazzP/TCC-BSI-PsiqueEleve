import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String title;
  final String message;
  final String code;

  const Failure({required this.title, required this.message, this.code = ''});

  @override
  List<Object> get props => [title, message];

  @override
  bool get stringify => true;
}

const kAppFailure = AppFailure();
const kAppTimeoutFailure = AppFailure('999');
const kServerFailure = ServerFailure();
const kCacheFailure = CacheFailure();
const kCredentialsFailure = CredentialsFailure();
const kConnectionFailure = ConnectionFailure();
const kExpiredSession = ExpiredSessionFailure();
const kUserNotFoundResetPasswordFailure = UserNotFoundResetPasswordFailure();
const kAlreadyUsedHourAppointmentFailure = AlreadyUsedHourAppointmentFailure();
const kHourOnPastAppointmentFailure = HourOnPastAppointmentFailure();

class ExpiredSessionFailure extends Failure {
  const ExpiredSessionFailure()
      : super(
            title: 'Sessão expirada',
            message: 'Sua sessão expirou, feche e abra novamente o aplicativo. '
                'A ação não foi concluída.');
}

class AppFailure extends Failure {
  const AppFailure([String? code])
      : super(
          title: 'Algo deu errado',
          message: 'Ocorreu um erro interno na aplicação, a ação não foi concluída.',
          code: code ?? '',
        );
}

class ServerFailure extends Failure {
  const ServerFailure()
      : super(
            title: 'Algo deu errado',
            message: 'Estamos com instabilidade, a ação não foi concluída.');
}

class CacheFailure extends Failure {
  const CacheFailure()
      : super(title: 'Algo deu errado', message: 'Não foi possível carregar as informações.');
}

class CredentialsFailure extends Failure {
  const CredentialsFailure()
      : super(
          title: 'Falha no login',
          message: 'Seu usuário ou senha estão incorretos, tente novamente.',
        );
}

class ConnectionFailure extends Failure {
  const ConnectionFailure()
      : super(
            title: 'Falha na conexão',
            message: 'Encontramos uma falha na conexão,'
                '\nverifique sua internet e tente novamente.');
}

class ParseEntityFailure extends Failure {
  const ParseEntityFailure(Type entity)
      : super(
          title: 'Falha no sistema',
          message: 'Houve uma falha ao traduzir a mensagem do servidor, '
              'tente novamente ou contacte o suporte.',
          code: '100$entity',
        );
}

class UserNotFoundResetPasswordFailure extends Failure {
  const UserNotFoundResetPasswordFailure()
      : super(
          title: 'Erro ao resetar senha',
          message: 'Não foi possível encontrar o usuário, tente novamente com outro e-mail.',
        );
}

class AlreadyUsedHourAppointmentFailure extends Failure {
  const AlreadyUsedHourAppointmentFailure()
      : super(
          title: 'Erro ao agendar',
          message:
              'Esse horário já foi utilizado, tente outro horário com pelo menos 30 minutos de diferença.',
        );
}

class HourOnPastAppointmentFailure extends Failure {
  const HourOnPastAppointmentFailure()
      : super(
          title: 'Erro ao agendar',
          message: 'Não é possível criar agendamentos em um horário que já passou.',
        );
}
