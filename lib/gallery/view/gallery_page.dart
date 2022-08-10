import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_repository/images_repository.dart';
import 'package:super_gallery_v2/gallery/gallery.dart';

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
      ),
      child: Container(),
    );
  }
}

class _GalleryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Card> _buildGridCards(int count) {
      final cards = List.generate(
        count,
        (int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18 / 11,
                  child: Image.network(
                    context.select(
                      (GalleryCubit cubit) => cubit.state.images[index],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text('Title'),
                      SizedBox(height: 8),
                      Text('Secondary Text'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
      return cards;
    }

    return Scaffold(
      body: SafeArea(
        child: BlocListener<GalleryCubit, GalleryState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            childAspectRatio: 8 / 9,
            children: _buildGridCards(
              context.select((GalleryCubit cubit) => cubit.state.images.length),
            ),
          ),
        ),
      ),
    );
  }
}
