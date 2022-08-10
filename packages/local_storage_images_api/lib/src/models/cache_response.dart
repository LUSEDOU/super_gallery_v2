import 'package:images_api/images_api.dart';

/// {@template cache_response}
/// A response from the cache
/// {@endtemplate}
class CacheResponse implements ApiResponse<dynamic> {
  /// {@macro cache_response}
  const CacheResponse({
    required this.data,
  });

  /// Converts a [Map<String, dynamic>] into a Response
  factory CacheResponse.fromJson(Map<String, dynamic> json) {
    return CacheResponse(
      data: json['data'],
    );
  }

  /// Converts the response into a [Map<String, dynamic>]
  Map<String, dynamic> toJson() {
    return {'data': data};
  }

  @override

  /// The data contained by the response
  final dynamic data;
}
