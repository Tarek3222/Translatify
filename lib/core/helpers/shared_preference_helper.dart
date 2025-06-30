// ignore_for_file: type_literal_in_constant_pattern

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences _sharedPreferences;
  SharedPrefHelper(this._sharedPreferences);

  /// Removes a value from SharedPreferences with given [key].
  Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    await _sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    await _sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  Future<void> setData(String key, value) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case String:
        await _sharedPreferences.setString(key, value);
        break;
      case int:
        await _sharedPreferences.setInt(key, value);
        break;
      case bool:
        await _sharedPreferences.setBool(key, value);
        break;
      case double:
        await _sharedPreferences.setDouble(key, value);
        break;
      default:
        return;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  bool getBool(String key) {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    return _sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  double getDouble(String key) {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  int getInt(String key) {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    return _sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  String? getString(String key) {
    debugPrint('SharedPrefHelper : getString with key : $key');
    return _sharedPreferences.getString(key);
  }

  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  Map<String, dynamic>? getMap(String key) =>
      containsKey(key) ? json.decode(getString(key) ?? '') : null;

  Future<void> setMap(String key, Map<String, dynamic> value) async {
    await setData(key, json.encode(value));
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  Future<String?> getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key :');
    return await flutterSecureStorage.read(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage
  clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}
