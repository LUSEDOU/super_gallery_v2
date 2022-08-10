/// {@template images_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ImagesApi {
  /// {@macro images_api}
  const ImagesApi();
}

/// {@template local_storage_api}
/// A model of a LocalStorageAPI
/// {@endtemplate}
abstract class LocalStorageApi extends ImagesApi {
  /// Inits the storage
  Future<void> init();

  /// Remove a value associated with the key from the storage
  Future<void> remove(String key);

  /// Get a value associated with the key from the storage
  dynamic get(String key);

  /// Get all values from the storage
  dynamic getAll();

  /// Clear the storage
  Future<void> clear();

  /// If a value associated with a key is contained into the storage
  bool has(String key);

  /// Write a value in the storage
  Future<void> write(String key, dynamic data);

  /// Close the storage
  Future<void> close();
}
