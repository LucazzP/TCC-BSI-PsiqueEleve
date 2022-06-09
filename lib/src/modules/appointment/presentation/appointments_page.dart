import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/extensions/date_time.ext.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
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
    controller.init();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Widget? get floatingActionButton => Observer(
        builder: (context) => controller.shouldShowCreateButton
            ? FloatingActionButton(
                onPressed: controller.onTapAddEditAppointment,
                backgroundColor: AppColorScheme.primaryButtonBackground,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : const SizedBox(),
      );

  @override
  Widget child(context, constrains) {
    return Observer(builder: (context) {
      final appointments = controller.appointments.value;
      if (appointments.isEmpty && !controller.isLoading) {
        return const Center(
          child: Text('Não há nenhuma consulta marcada.'),
        );
      }
      return RefreshIndicator(
        onRefresh: () => controller.getAppointments(false),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];
            return _ListTile(
              appointment: appointment,
              onTap: () => controller.onTapAddEditAppointment(appointment),
            );
          },
        ),
      );
    });
  }
}

class _ListTile extends StatelessWidget {
  final AppointmentEntity appointment;
  final VoidCallback onTap;

  const _ListTile({
    Key? key,
    required this.appointment,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(appointment.therapistPatientRelationship.patient.fullName),
      trailing: Text(appointment.date.formatWithHour),
      subtitle: Text(appointment.status.friendlyName),
      onTap: onTap,
      textColor: appointment.status.color,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s24,
        vertical: AppSpacing.s4,
      ),
    );
  }
}
