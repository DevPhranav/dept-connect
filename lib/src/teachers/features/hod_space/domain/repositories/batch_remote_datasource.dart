abstract class HodBatchRemoteDataSource {
  Future<List<String>> fetchBatchIdsFromDatabase(String dept,String facultyId,String role);
}