import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';

import 'appointments_controller.dart';

class AppointmentsPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeAppointmentsScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeAppointmentsScreenRoute);

  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends BaseState<AppointmentsPage, AppointmentsController> {
  @override
  void initState() {
    controller.getAppointments();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget child(context, constrains) {
    return Observer(builder: (context) {
      final appointments = controller.appointments.value;
      if (appointments.isEmpty && !controller.isLoading) {
        return const Center(
          child: Text('Não há nenhuma consulta marcada.'),
        );
      }
      return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            title: Text(appointment.status.name),
            onTap: () => controller.onTapAddEditAppointment(appointment),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s24,
              vertical: AppSpacing.s4,
            ),
          );
        },
      );
    });
  }
}
