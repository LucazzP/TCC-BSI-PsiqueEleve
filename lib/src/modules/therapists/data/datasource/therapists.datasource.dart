abstract class TherapistsDataSource {
  Future<List<Map>> getTherapists({int page = 0});
  Future<Map> updateTherapist(Map therapist);
  Future<Map> createTherapist(Map therapist);
}
