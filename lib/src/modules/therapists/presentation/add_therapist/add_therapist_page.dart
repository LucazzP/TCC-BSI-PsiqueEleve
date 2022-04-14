import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'add_therapist_controller.dart';

class AddTherapistPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kTherapistAddScreenRoute);

  const AddTherapistPage({Key? key}) : super(key: key);

  @override
  _AddTherapistPageState createState() => _AddTherapistPageState();
}

class _AddTherapistPageState extends BaseState<AddTherapistPage, AddTherapistController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text('Adicionar terapeuta'),
      );

  @override
  Widget child(context, constrains) {
    return Container();
  }
}
