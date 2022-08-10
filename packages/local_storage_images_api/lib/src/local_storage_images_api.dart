import 'package:hive_flutter/hive_flutter.dart';
import 'package:images_api/images_api.dart';

/// {@template local_storage}
/// A local storage implemented with Hive package
/// {@endtemplate}
class LocalStorageImagesApi implements LocalStorageApi {
  /// The storage
  late Box<dynamic> hiveBox;

  /// Open the storage
  Future<void> openBox([String boxName = 'IMAGE_CACHE']) async {
    hiveBox = await Hive.openBox(boxName);
  }

  /// Initialize the storage
  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await openBox();
  }

  /// Remove the [key] from the storage
  @override
  Future<void> remove(String key) async => hiveBox.delete(key);

  /// Get the associated value from the storage
  @override
  dynamic get(String key) => hiveBox.get(key);

  /// Returns all values in the storage
  @override
  dynamic getAll() => hiveBox.values.toList();

  /// If the storage contains the value
  @override
  bool has(String key) => hiveBox.containsKey(key);

  /// Write the key/value in the storage
  @override
  Future<void> write(String key, dynamic data) => hiveBox.put(key, data);

  /// Delete all the data in the storage
  @override
  Future<void> clear() => hiveBox.clear();

  /// Close the storage
  @override
  Future<void> close() => hiveBox.close();
}
