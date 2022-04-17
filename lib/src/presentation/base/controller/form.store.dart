import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'form.store.g.dart';

class FormStore = _FormStoreBase with _$FormStore;

abstract class _FormStoreBase extends Disposable with Store {
  final String? Function(String? value) validator;
  TextEditingController? _controller;

  _FormStoreBase(this.validator, {this.value = ''});

  TextEditingController get controller {
    final textController = _controller ?? TextEditingController();
    if (_controller == null) {
      _controller = textController;
      textController.addListener(() {
        if (textController.text != value) setValue(textController.text);
      });
    }
    return textController;
  }

  @observable
  String value;

  @observable
  String? error;

  @action
  void setValue(String value) {
    this.value = value;
    if (controller.text != value) controller.text = value;
  }

  @action
  void setError(String? error) {
    this.error = error;
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
