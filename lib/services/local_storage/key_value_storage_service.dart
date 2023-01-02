abstract class KeyValueStorageService {
  Future<void> saveString(String key, String value);
  Future<String?> readString(String key);
  Future<void> deleteString(String key);
  Future<void> initialize();
  Future<bool> hasValue(String key);
}
