extension UriExtension on Uri {
  Uri get fromDeepLink {
    try {
      origin;
    } catch (_) {
      final params = Uri.splitQueryString(fragment);
      return Uri(
        queryParameters: params,
      );
    }
    return this;
  }
}
