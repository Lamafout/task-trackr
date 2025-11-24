class NoIDException implements Exception {
  @override
  String toString() => 'No token into cache';
}
class InternetException implements Exception {
  InternetException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}