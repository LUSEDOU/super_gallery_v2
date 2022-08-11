import 'package:images_api/images_api.dart';

/// {@template images_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class ImagesRepository {
  /// Get a list of images' urls
  List<String> getImages();

  /// Return a dynamic for a request from the [LocalStorageApi]
  List<dynamic> getFromCache();

  /// Delete a image from the [LocalStorageApi]
  Future<void> deleteImage(String image);

  /// Add a image to the [LocalStorageApi]
  Future<void> addImage(String image);

  /// Clear the cache
  void clear();
}

/// {@template cache_images_repository}
/// A repository of images from cache
/// {@endtemplate}
class CacheImagesRepository implements ImagesRepository {
  /// {@macro cache_images_repository}
  const CacheImagesRepository({
    required this.localStorageApi,
  });

  /// A local storage or cache
  final LocalStorageApi localStorageApi;

  @override
  List<String> getImages() {
    final images = getFromCache().map((e) => e.toString()).toList();

    return images;
  }

  @override
  List<dynamic> getFromCache() {
    return localStorageApi.getAll();
  }

  @override
  Future<void> deleteImage(String image) async {
    await localStorageApi.remove(image);
  }

  @override
  Future<void> addImage(String image) async {
    await localStorageApi.write(image, image);
  }

  @override
  void clear() {
    localStorageApi.clear();
  }
}
