class FlavorValues {
  const FlavorValues({
    required this.baseUrl,
    required this.publicAnonKey,
    required Map<String, dynamic> Function() features,
  }) : _features = features;

  final String baseUrl;
  final String publicAnonKey;
  final Map<String, dynamic> Function() _features;

  Map<String, dynamic> get features => _features();
}
