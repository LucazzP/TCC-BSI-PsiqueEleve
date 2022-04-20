import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_snackbar/app_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      Modular.to.navigate(kAuthLoginScreenRoute);
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted && !Uri.base.queryParameters.values.contains('recovery')) {
      Modular.to.navigate(kHomeFeedScreenRoute);
    }
  }

  @override
  void onPasswordRecovery(Session session) {
    if (mounted) {
      Modular.to.navigate(kAuthResetPasswordScreenRoute);
    }
  }

  @override
  void onErrorAuthenticating(String message) {
    AppSnackBar.error(context, message);
  }
}
