const kSplashScreenRoute = '/';
const kHomeScreenRoute = '/home/';
const kAuthModuleRoute = '/auth/';
const kAuthLoginScreenRoute = '${kAuthModuleRoute}login';

extension RouterExtension on String {
  String get finalPath {
    final splitted = split('/');
    if (endsWith('/')) {
      return '/' + splitted[splitted.length - 2];
    }
    return '/' + splitted[splitted.length - 1];
  }
}
