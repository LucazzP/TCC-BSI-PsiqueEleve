extension UriExtension on Uri {
  Uri copyWith({
    String? scheme,
    String? userInfo,
    String? host,
    int? port,
    String? path,
    Iterable<String>? pathSegments,
    String? query,
    Map<String, dynamic>? queryParameters,
    String? fragment,
  }) {
    return Uri(
      scheme: scheme ?? this.scheme,
      userInfo: userInfo ?? this.userInfo,
      host: host ?? this.host,
      port: port ?? this.port,
      path: path ?? this.path,
      pathSegments: pathSegments ?? this.pathSegments,
      query: query ?? this.query,
      queryParameters: queryParameters ?? this.queryParameters,
      fragment: fragment ?? this.fragment,
    );
  }
}
