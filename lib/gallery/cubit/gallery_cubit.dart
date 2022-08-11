import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:images_repository/images_repository.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit({required this.imagesRepository}) : super(const GalleryState());

  final ImagesRepository imagesRepository;

  Future<void> init() async {
    emit(
      state.copyWith(
        images: imagesRepository.getImages(),
        status: GalleryStatus.loading,
      ),
    );
  }

  void imagesCached() {
    emit(state.copyWith(status: GalleryStatus.success));
  }

  void clear() {
    emit(state.copyWith(status: GalleryStatus.loading));
    imagesRepository.clear();
    emit(const GalleryState());
  }
}
