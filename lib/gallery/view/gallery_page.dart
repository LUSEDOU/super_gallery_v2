import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_repository/images_repository.dart';
import 'package:super_gallery_v2/gallery/gallery.dart';
import 'package:super_gallery_v2/upload/view/upload_page.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const GalleryPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryCubit(
        imagesRepository: context.read<CacheImagesRepository>(),
      )..init(),
      child: _GalleryView(),
    );
  }
}

class _GalleryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GestureDetector> _buildGridCards(List<String> urls) {
      final cards = List.generate(
        urls.length,
        (int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              CarouselPage.route(
                index: index,
                images: urls,
              ),
            ),
            child: Card(
              key: Key('CARD$index'),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: urls[index],
                progressIndicatorBuilder: (context, url, progress) =>
                    const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          );
        },
      );
      return cards;
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          childAspectRatio: 8 / 9,
          children: _buildGridCards(
            context.select((GalleryCubit cubit) => cubit.state.images),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () => Navigator.of(context).pop(
          UploadPage.route(),
        ),
      ),
    );
  }
}
