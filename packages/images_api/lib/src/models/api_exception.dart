/// {@template api_exception}
/// Throw if during any process from the API if a failure occurs
/// {endtemplate}
abstract class ApiException implements Exception {
  /// {@macro api_exception}
  const ApiException({
    required this.title,
    String? message,
  }) : message = message ?? 'An unknown exception ocurred';

  /// The title for the exceptions
  final String title;

  /// The message from the error
  final String message;
}
