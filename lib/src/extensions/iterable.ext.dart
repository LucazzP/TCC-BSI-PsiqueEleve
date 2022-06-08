import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:flinq/flinq.dart';

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

extension IterableMapExtension on List<Map> {
  List<Map> removeEqualIds() {
    final ids = map((e) => e['id']).toSet();
    return ids
        .map((id) => firstOrNullWhere((element) => element['id'] == id))
        .whereNotNull()
        .toList();
  }
}
