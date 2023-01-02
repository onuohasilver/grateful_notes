import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'key_value_storage_service.dart';

class FlutterSecureStorageImpl implements KeyValueStorageService {
  final FlutterSecureStorage storage;
  const FlutterSecureStorageImpl({this.storage = const FlutterSecureStorage()});
  @override
  Future<void> saveString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<String?> readString(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> deleteString(String key) async {
    return await storage.delete(key: key);
  }

  Future<void> saveBool(String key, bool value) async {
    await storage.write(key: key, value: jsonEncode({'value': value}));
  }

  @override
  Future<bool> hasValue(String key) async {
    return await storage.containsKey(key: key);
  }

  Future<bool> readBool(String key) async {
    String? response = await storage.read(key: key);
    if (response == null) return false;
    return jsonDecode(response)['value'];
  }

  Future<void> close() async {
    await storage.deleteAll();
  }

  @override
  Future<void> initialize() async {}
}
