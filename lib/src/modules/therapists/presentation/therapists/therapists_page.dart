import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';

import 'therapists_controller.dart';

class TherapistsPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kTherapistsScreenRoute);

  const TherapistsPage({Key? key}) : super(key: key);

  @override
  _TherapistsPageState createState() => _TherapistsPageState();
}

class _TherapistsPageState extends BaseState<TherapistsPage, TherapistsController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text('Terapeutas'),
      );

  @override
  Widget? get floatingActionButton => FloatingActionButton(
        onPressed: controller.onTapAddTherapist,
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColorScheme.primaryButtonBackground,
      );

  @override
  void initState() {
    controller.getTherapists();
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return Observer(builder: (context) {
      final therapists = controller.therapists.value;
      if (therapists.isEmpty && !controller.isLoading) {
        return const Center(
          child: Text('Nenhum terapeuta cadastrado'),
        );
      }
      return ListView.builder(
        itemCount: therapists.length,
        itemBuilder: (context, index) {
          final therapist = therapists[index];
          return ListTile(
            title: Text(therapist.fullName),
          );
        },
      );
    });
  }
}
