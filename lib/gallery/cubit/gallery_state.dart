part of 'gallery_cubit.dart';

enum GalleryStatus { initial, loading, success }

class GalleryState extends Equatable {
  const GalleryState({
    this.images = const [],
    this.status = GalleryStatus.initial,
  });

  final List<String> images;
  final GalleryStatus status;

  GalleryState copyWith({
    List<String>? images,
    GalleryStatus? status,
  }) {
    return GalleryState(
      images: images ?? this.images,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [images];
}
