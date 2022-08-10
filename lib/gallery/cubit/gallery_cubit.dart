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
        status: GalleryStatus.loading,
        images: await imagesRepository.getImages(),
      ),
    );
  }

  void imagesCached() {
    emit(state.copyWith(status: GalleryStatus.success));
  }
}
