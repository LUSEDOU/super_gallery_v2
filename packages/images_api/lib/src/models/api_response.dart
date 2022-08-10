/// {@template api_response}
/// A model of a response from the API API
/// {@endtemplate}
abstract class ApiResponse<T> {
  /// {@macro api_response}
  const ApiResponse({
    required this.data,
  });

  /// The data responded
  final T data;
}
