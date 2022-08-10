import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:images_repository/images_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'upload_event.dart';
part 'upload_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc({
    required this.imagesRepository,
  }) : super(const UploadState()) {
    on<UploadImageSaveRequest>(_onUploadImageSaveRequest);
    on<UploadImageSaved>(_onUploadImageSaved);
    on<UploadUrlChange>(
      _onUploadUrlChange,
      transformer: debounce(_duration),
    );
    on<UploadFailureLoad>(_onUploadFailureLoad);
    on<UploadImageDelete>(_onUploadImageDelete);
    on<UploadImageChanged>(_onUploadImageChanged);
  }

  final ImagesRepository imagesRepository;

  void _onUploadUrlChange(
    UploadUrlChange event,
    Emitter<UploadState> emit,
  ) {
    emit(state.copyWith(image: event.url));
  }

  void _onUploadImageSaveRequest(
    UploadImageSaveRequest event,
    Emitter<UploadState> emit,
  ) {
    emit(state.copyWith(status: UploadStatus.saving));
  }

  void _onUploadImageSaved(
    UploadImageSaved event,
    Emitter<UploadState> emit,
  ) {
    try {
      imagesRepository.addImage(state.image);
      emit(
        state.copyWith(
          status: UploadStatus.success,
          urls: state.urls..add(state.image),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: UploadStatus.failure));
    }
  }

  void _onUploadFailureLoad(
    UploadFailureLoad event,
    Emitter<UploadState> emit,
  ) {
    emit(
      state.copyWith(status: UploadStatus.failure),
    );
  }

  void _onUploadImageDelete(
    UploadImageDelete event,
    Emitter<UploadState> emit,
  ) {
    emit(
      state.copyWith(status: UploadStatus.loading),
    );

    try {
      imagesRepository.deleteImage(event.image);
      emit(
        state.copyWith(
          status: UploadStatus.success,
          urls: state.urls..remove(event.image),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: UploadStatus.failure));
    }
  }

  void _onUploadImageChanged(
    UploadImageChanged event,
    Emitter<UploadState> emit,
  ) {
    emit(state.copyWith(image: event.image));
  }
}
