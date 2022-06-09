import 'package:flutter/material.dart';
import 'package:psique_eleve/src/core/constants.dart';

class TernaryWidget extends StatelessWidget {
  final bool value;
  final Widget trueWidget;
  final Widget falseWidget;
  final bool useAnimation;

  const TernaryWidget({
    Key? key,
    required this.value,
    this.trueWidget = const SizedBox.shrink(),
    this.falseWidget = const SizedBox.shrink(),
    this.useAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (useAnimation) {
      return AnimatedCrossFade(
        firstChild: trueWidget,
        secondChild: falseWidget,
        crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: kAnimationDuration,
      );
    }
    return value ? trueWidget : falseWidget;
  }
}
