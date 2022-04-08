const kSplashScreenRoute = '/';
const kHomeScreenRoute = '/home';
const kAuthModuleRoute = '/auth';
const kAuthLoginScreenRoute = '$kAuthModuleRoute/login';

extension RouterExtension on String {
  String get finalPath => '/' + split('/').last;
}
