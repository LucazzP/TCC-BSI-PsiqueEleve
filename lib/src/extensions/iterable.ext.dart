import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';

extension IterableExtension<T> on Iterable<T?> {
  Iterable<T> whereNotNull() sync* {
    for (final item in this) {
      if (item != null) {
        yield item;
      }
    }
  }
}

extension IterableFormExtension on Iterable<FormStore> {
  bool validate() {
    var hasError = false;
    for (var i = 0; i < length; i++) {
      final item = elementAt(i);
      final error = item.validator(item.value);
      if (error != null) {
        hasError = true;
      }
      item.setError(error);
    }
    return !hasError;
  }
}
