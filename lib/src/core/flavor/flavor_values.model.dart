class FlavorValues {
  const FlavorValues({
    required this.baseUrl,
    required this.publicAnonKey,
    required this.authCallbackUrlHostname,
    required Map<String, dynamic> Function() features,
  }) : _features = features;

  final String baseUrl;
  final String publicAnonKey;
  final String authCallbackUrlHostname;
  final Map<String, dynamic> Function() _features;

  Map<String, dynamic> get features => _features();
}
