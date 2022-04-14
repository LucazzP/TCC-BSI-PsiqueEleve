import 'package:psique_eleve/src/presentation/models/form_model.dart';

extension IterableExtension<T> on Iterable<T?> {
  Iterable<T> whereNotNull() sync* {
    for (final item in this) {
      if (item != null) {
        yield item;
      }
    }
  }
}

extension IterableFormExtension on Iterable<FormModel> {
  bool validate(void Function(int index, String error) setError) {
    var hasError = false;
    for (var i = 0; i < length; i++) {
      final item = elementAt(i);
      final error = item.validator(item.value);
      if (error != null) {
        setError(i, error);
        hasError = true;
      }
    }
    return !hasError;
  }
}
