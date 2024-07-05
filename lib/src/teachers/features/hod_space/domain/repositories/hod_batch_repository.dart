abstract class HodBatchRepository {
  Future<List<String>> fetchBatchIds(String dept,String facultyId,String role);
}
