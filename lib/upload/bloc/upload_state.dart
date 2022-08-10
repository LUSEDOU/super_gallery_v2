part of 'upload_bloc.dart';

enum UploadStatus { initial, loading, saving, success, failure }

class UploadState extends Equatable {
  const UploadState({
    this.status = UploadStatus.initial,
    this.urls = const [],
    this.image = '',
    this.errorMessage,
  });

  final UploadStatus status;
  final List<String> urls;
  final String image;
  final String? errorMessage;

  UploadState copyWith({
    UploadStatus? status,
    List<String>? urls,
    String? image,
    String? errorMessage,
  }) {
    return UploadState(
      status: status ?? this.status,
      urls: urls ?? this.urls,
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [image, status, urls, errorMessage];
}
