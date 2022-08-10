part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadUrlChange extends UploadEvent {
  const UploadUrlChange({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}

class UploadImageDelete extends UploadEvent {
  const UploadImageDelete({
    required this.image,
  });

  final String image;

  @override
  List<Object> get props => [image];
}

class UploadImageSaveRequest extends UploadEvent {
  const UploadImageSaveRequest({
    required this.image,
  });

  final String image;

  @override
  List<Object> get props => [image];
}

class UploadImageSaved extends UploadEvent {
  const UploadImageSaved();

  @override
  List<Object> get props => [];
}

class UploadFailureLoad extends UploadEvent {
  const UploadFailureLoad({
    this.errorMessage = 'Something wrong with the url',
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class UploadImageChanged extends UploadEvent {
  const UploadImageChanged({
    required this.image,
  });

  final String image;

  @override
  List<Object> get props => [image];
}
