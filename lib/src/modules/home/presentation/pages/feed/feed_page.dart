import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeFeedScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeFeedScreenRoute);

  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends BaseState<FeedPage, FeedController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget child(context, constrains) {
    return Column(
      children: [
        Observer(builder: (_) {
          return Text(controller.counter.value.toString());
        }),
        TextButton(
          onPressed: () {
            controller.counter.setValue(controller.counter.value + 1);
          },
          child: const Text('aumentar'),
        )
      ],
    );
  }
}
