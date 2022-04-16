import 'package:mobx/mobx.dart';
part 'form.store.g.dart';

class FormStore = _FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store {
  final String? Function(String? value) validator;

  _FormStoreBase(this.validator, {this.value = ''});

  @observable
  String value;

  @observable
  String? error;

  @action
  void setValue(String value) {
    this.value = value;
  }

  @action
  void setError(String? error) {
    this.error = error;
  }
}
