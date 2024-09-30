class NoIDException implements Exception {
  @override
  String toString() => 'No token into cache';
}
class InternetException implements Exception {
  @override
  String toString() => 'Error with Internet connection or from server. Try again later.';
}