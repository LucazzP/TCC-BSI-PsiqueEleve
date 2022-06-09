const kSplashScreenRoute = '/';

const kHomeModuleRoute = '/home';
const kHomeFeedScreenRoute = '$kHomeModuleRoute/feed';
const kHomeAppointmentsScreenRoute = '$kHomeModuleRoute/home_appointments/';
const kHomeTasksScreenRoute = '$kHomeModuleRoute/home_tasks/';
const kHomeMenuScreenRoute = '$kHomeModuleRoute/menu/';

const kAuthModuleRoute = '/auth';
const kAuthLoginScreenRoute = '$kAuthModuleRoute/';
const kAuthRecoverPasswordScreenRoute = '$kAuthModuleRoute/recoverPassword';
const kAuthResetPasswordScreenRoute = '$kAuthModuleRoute/resetPassword';

const kUsersModuleRoute = '$kHomeModuleRoute/users';
const kUsersScreenRoute = '$kUsersModuleRoute/';
const kUserAddEditScreenRoute = '$kUsersModuleRoute/add';

const kAddressModuleRoute = '$kUsersModuleRoute/address';
const kAddressScreenRoute = '$kAddressModuleRoute/';

const kAppointmentsModuleRoute = '$kHomeModuleRoute/appointments';
const kAppointmentAddEditScreenRoute = '$kAppointmentsModuleRoute/add';

const kTasksModuleRoute = '$kHomeModuleRoute/tasks';
const kTasksScreenRoute = '$kTasksModuleRoute/';
const kTaskAddEditScreenRoute = '$kTasksModuleRoute/add';

extension RouterExtension on String {
  String get finalPath {
    final splitted = split('/');
    if (endsWith('/')) {
      return '/${splitted[splitted.length - 2]}';
    }
    return '/${splitted[splitted.length - 1]}';
  }
}
