import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_repository/images_repository.dart';
import 'package:super_gallery_v2/gallery/view/view.dart';
import 'package:super_gallery_v2/upload/upload.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: UploadPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UploadBloc(imagesRepository: context.read<CacheImagesRepository>()),
      child: _UploadView(),
    );
  }
}

class _UploadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        if (state.status == UploadStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something wrong happened'),
              ),
            );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  _UploadForm(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  _BigImage(),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  _UploadImages()
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.browse_gallery_rounded),
          onPressed: () {
            Navigator.of(context).push(
              GalleryPage.route(),
            );
          },
        ),
      ),
    );
  }
}

class _BigImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) {
        return state.status == UploadStatus.initial
            ? Container()
            : ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: state.image,
                  fit: BoxFit.fitWidth,
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    context.read<UploadBloc>().add(
                          UploadFailureLoad(errorMessage: error.toString()),
                        );
                    return const SizedBox();
                  },
                ),
              );
      },
    );
  }
}

@immutable
class _SmallImage extends StatelessWidget {
  const _SmallImage({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return image.isEmpty
        ? Container(
            color: Colors.red,
            width: 9,
            height: 9,
          )
        : Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    context.read<UploadBloc>().add(
                          UploadFailureLoad(errorMessage: error.toString()),
                        );
                    return const SizedBox();
                  },
                ),
              ),
              onTap: () => context
                  .read<UploadBloc>()
                  .add(UploadImageChanged(image: image)),
              onLongPress: () => context
                  .read<UploadBloc>()
                  .add(UploadImageDelete(image: image)),
            ),
          );
  }
}

class _UploadForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) {
        if (state.status == UploadStatus.saving) {
          context.read<UploadBloc>().add(
                const UploadImageSaved(),
              );
        }

        return TextField(
          controller: _controller,
          onChanged: (text) {},
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () async {
                context.read<UploadBloc>().add(
                      UploadImageSaveRequest(
                        image: _controller.text,
                      ),
                    );
                _controller.clear();
              },
              icon: const Icon(Icons.save_alt_rounded),
            ),
            enabled: state.urls.length < 5,
          ),
        );
      },
    );
  }
}

class _UploadImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) {
        List<Widget> _smallImage(int length) => List.generate(
              length,
              (index) => _SmallImage(
                image: state.urls[index],
              ),
            );

        final urlLength = state.urls.length;

        return state.urls.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _smallImage(
                    urlLength <= 5 ? urlLength : 5,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
