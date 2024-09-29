class NoIDException implements Exception {
  @override
  String toString() => 'No token into cache';
}