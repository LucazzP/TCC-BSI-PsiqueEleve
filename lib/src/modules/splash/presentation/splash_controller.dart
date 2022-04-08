import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase extends BaseStore with Store {
  final GetUserLoggedUseCase _getUserLoggedUseCase;

  _SplashControllerBase(this._getUserLoggedUseCase);

  void onInit() {}

  @override
  Iterable<ValueState> get getStates => [];
}
