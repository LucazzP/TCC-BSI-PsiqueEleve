import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/therapists/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/add_therapist/add_therapist_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';

part 'therapists_controller.g.dart';

class TherapistsController = _TherapistsControllerBase with _$TherapistsController;

abstract class _TherapistsControllerBase extends BaseStore with Store {
  final GetTherapistsUseCase _getTherapistsUseCase;

  _TherapistsControllerBase(this._getTherapistsUseCase);

  final therapists = ValueState<List<UserEntity>>([]);

  @override
  Iterable<ValueState> get getStates => [therapists];

  Future<void> getTherapists([int page = 0]) {
    return therapists.execute(() => _getTherapistsUseCase.call(page));
  }

  void onTapAddTherapist() {
    AddTherapistPage.navigateTo();
  }
}
