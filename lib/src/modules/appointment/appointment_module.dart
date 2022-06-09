import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/appointment/data/repository/appointment_impl.repository.dart';
import 'package:psique_eleve/src/modules/appointment/domain/repository/appointment.repository.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/delete_appointment.usecase.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/add_edit_appointment/add_edit_appointment_page.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/appointments_controller.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/appointments_page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

import 'data/datasource/remote/appointment_remote.datasource.dart';
import 'data/datasource/remote/appointment_remote_impl.datasource.dart';
import 'domain/usecases/create_appointment.usecase.dart';
import 'domain/usecases/get_appointment.usecase.dart';
import 'domain/usecases/get_appointments.usecase.dart';
import 'domain/usecases/update_appointment.usecase.dart';
import 'presentation/add_edit_appointment/add_edit_appointment_controller.dart';

class AppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppointmentsController(i(), i())),
    Bind.lazySingleton((i) => AddEditAppointmentController(i(), i(), i(), i())),
    Bind.factory((i) => UpdateAppointmentUseCase(i())),
    Bind.factory((i) => DeleteAppointmentUseCase(i())),
    Bind.factory((i) => CreateAppointmentUseCase(i())),
    Bind.factory((i) => GetAppointmentUseCase(i())),
    Bind.factory((i) => GetAppointmentsUseCase(i())),
    Bind.factory<AppointmentRepository>((i) => AppointmentRepositoryImpl(i())),
    Bind.factory<AppointmentRemoteDataSource>((i) => AppointmentRemoteDataSourceImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const AppointmentsPage(),
    ),
    ChildRoute(
      kAppointmentAddEditScreenRoute.finalPath,
      child: (_, args) => AddEditAppointmentPage(appointment: args.data),
    ),
  ];
}
