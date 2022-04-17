class Casters {
  static Map toMap(dynamic value) {
    if (value is List) {
      if (value.isNotEmpty) return Map.from(value[0] ?? {});
      return {};
    }
    return Map.from(value ?? {});
  }

  static List<Map> toListMap(dynamic value) {
    return List.castFrom<dynamic, Map>(value ?? []);
  }
}
