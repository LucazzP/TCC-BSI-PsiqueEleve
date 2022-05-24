import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/extensions/context.ext.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/pages/reaction.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/widgets/error/error.widget.dart';
import 'package:psique_eleve/src/presentation/widgets/overlay/overlay.widget.dart';

abstract class BaseState<T extends StatefulWidget, S extends BaseStore> extends State<T> {
  final S _scope = Modular.get<S>();
  S get controller => _scope;

  static const errorKey = Key('ErrorWidgetKey');
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Color get bgColor => AppColorScheme.colorScheme.background;
  bool get shouldRemoveAppbarHeight => false;
  bool get showLoadingOverlay => true;
  bool get showErrorOverlay => true;
  bool get safeAreaBottom => true;
  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 16, horizontal: 16);
  Widget? get bottomNavigationBar => null;
  Widget? get floatingActionButton => null;

  @visibleForTesting
  @nonVirtual
  final List<mobx.ReactionDisposer> disposers = [];

  Widget child(BuildContext context, BoxConstraints constraints);

  /// Roda a função imediatamente ao abrir a page e também quando algum dos
  /// observables for alterado.
  final List<void Function()> autoRun = [];

  /// Roda a função sempre que algum dos observables for alterado.
  final List<Reaction> reaction = [];

  /// A diferença entre o `when` e o `reaction` é que esse roda apenas uma vez,
  /// depois que a condição for satisfeita, ele sofre automaticamente um dispose
  ///
  /// item1: Condição para rodar a outra função (precisa possuir um observer
  /// para a função rodar automaticamente)
  ///
  /// item2: Função que irá executar caso a condição seja verdadeira.
  final List<Tuple2<bool Function(mobx.Reaction _), void Function()>> when = [];

  @visibleForTesting
  static const basePagePaddingKey = Key('basePagePadding');

  PreferredSizeWidget? appBar(BuildContext ctx);

  PreferredSizeWidget? _buildAppBar(BuildContext ctx) {
    return appBar(ctx);
  }

  bool get hasAppBar => scaffoldKey.currentState?.hasAppBar ?? false;

  @override
  @mustCallSuper
  void initState() {
    disposers.addAll(autoRun.map((func) => mobx.autorun((_) => func())));
    disposers.addAll(reaction.map((reaction) => reaction.toReaction()));
    disposers.addAll(
      when.map((tuple) => mobx.when(tuple.value1, tuple.value2)),
    );
    Modular.dispose<S>();
    super.initState();
  }

  @visibleForTesting
  void disposeFunc() {
    for (final dispose in disposers) {
      dispose();
    }
    controller.dispose();
  }

  bool supportScrolling(BuildContext context) => context.isSmallDevice;

  @visibleForTesting
  void onClearError() {}

  @override
  void dispose() {
    disposeFunc();
    super.dispose();
  }

  Widget loader = const Center(child: CircularProgressIndicator(color: AppColorScheme.white));

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    final _appBar = _buildAppBar(context);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
          backgroundColor: bgColor,
          appBar: _appBar,
          key: scaffoldKey,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          body: SafeArea(
            top: hasAppBar,
            bottom: safeAreaBottom,
            child: LayoutBuilder(
              builder: (_, BoxConstraints constrains) {
                final layoutWithPadding = Padding(
                  key: basePagePaddingKey,
                  padding: padding,
                  child: child(context, constrains),
                );

                return supportScrolling(context)
                    ? SingleChildScrollView(child: layoutWithPadding)
                    : layoutWithPadding;
              },
            ),
          ),
        ),
        if (showLoadingOverlay)
          Observer(builder: (_) {
            return (controller.isLoading && !controller.hasFailure)
                ? FutureBuilder(
                    future: Future.delayed(k100msDuration),
                    builder: (context, future) {
                      return future.connectionState == ConnectionState.done &&
                              (controller.isLoading && !controller.hasFailure)
                          ? OverlayWidget(child: loader)
                          : const SizedBox.shrink();
                    },
                  )
                : const SizedBox.shrink();
          }),
        if (showErrorOverlay)
          Observer(builder: (_) {
            return controller.hasFailure
                ? ErrorWidget(
                    key: errorKey,
                    failure: controller.failure!,
                    clearErrorState: () {
                      controller.clearErrors();
                      onClearError();
                    },
                  )
                : const SizedBox.shrink();
          })
      ],
    );
  }
}
