import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_snackbar/app_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    Modular.to.navigate(kAuthLoginScreenRoute);
  }

  @override
  void onAuthenticated(Session session) {
    if (!Uri.base.queryParameters.values.contains('recovery')) {
      Modular.to.navigate(kHomeFeedScreenRoute);
    }
  }

  @override
  void onPasswordRecovery(Session session) {
    Modular.to.navigate(kAuthResetPasswordScreenRoute);
  }

  @override
  void onErrorAuthenticating(String message) {
    if (mounted) {
      AppSnackBar.error(context, message);
    }
  }
}
