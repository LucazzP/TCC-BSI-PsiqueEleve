const kSplashScreenRoute = '/';
const kHomeModuleRoute = '/home/';
const kHomeFeedScreenRoute = '${kHomeModuleRoute}feed';
const kHomeAppointmentsScreenRoute = '${kHomeModuleRoute}appointments/';
const kHomeTasksScreenRoute = '${kHomeModuleRoute}tasks/';
const kHomeMenuScreenRoute = '${kHomeModuleRoute}menu/';
const kAuthModuleRoute = '/auth/';
const kAuthLoginScreenRoute = '${kAuthModuleRoute}login';
const kTherapistsScreenRoute = '${kHomeModuleRoute}therapists/';

extension RouterExtension on String {
  String get finalPath {
    final splitted = split('/');
    if (endsWith('/')) {
      return '/' + splitted[splitted.length - 2];
    }
    return '/' + splitted[splitted.length - 1];
  }
}
