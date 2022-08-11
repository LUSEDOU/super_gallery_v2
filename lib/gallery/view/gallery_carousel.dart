import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_repository/images_repository.dart';
import 'package:super_gallery_v2/gallery/gallery.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  static Route<void> route({required int index, required List<String> images}) {
    return MaterialPageRoute<void>(
      builder: (_) => _CarouselView(index: index, images: images),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _CarouselView extends StatelessWidget {
  const _CarouselView({required this.index, required this.images});

  final int index;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final _controller = SwiperController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Swiper(
          controller: _controller,
          itemCount: images.length,
          itemBuilder: (context, index) => CachedNetworkImage(
            imageUrl: images[index],
          ),
        ),
      ),
    );
  }
}
