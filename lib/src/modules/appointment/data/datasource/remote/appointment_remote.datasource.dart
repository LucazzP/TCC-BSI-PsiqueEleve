abstract class AppointmentRemoteDataSource {
  Future<Map> createAppointment(Map appointment);
  Future<List<Map>> getAppointments();
  Future<Map> getAppointment(String id);
  Future<Map> updateAppointment(Map appointment);
  Future<Map> deleteAppointment(Map appointment);
}
