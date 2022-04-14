import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
part 'add_therapist_controller.g.dart';

class AddTherapistController = _AddTherapistControllerBase with _$AddTherapistController;

abstract class _AddTherapistControllerBase extends BaseStore with Store {
  final newTherapist = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newTherapist];
}