import 'dart:convert';

import 'package:mmkv/mmkv.dart';

class MMKVUtil {
  static final _mmkv = MMKV.defaultMMKV();

  static bool put<T>(String key, T value) {
    if (value is String) {
      return _mmkv.encodeString(key, value);
    } else if (value is double) {
      return _mmkv.encodeDouble(key, value);
    } else if (value is int) {
      return _mmkv.encodeInt(key, value);
    } else if (value is bool) {
      return _mmkv.encodeBool(key, value);
    } else if (value is MMBuffer) {
      _mmkv.encodeBytes(key, value);
    }
    return false;
  }

  static int getInt(String key) {
    return _mmkv.decodeInt(key);
  }

  static double getDouble(String key) {
    return _mmkv.decodeDouble(key);
  }

  static String getString(String key) {
    return _mmkv.decodeString(key) ?? "";
  }

  static bool getBool(String key) {
    return _mmkv.decodeBool(key);
  }

  static String getByte(String key) {
    return const Utf8Decoder().convert(_mmkv.decodeBytes(key)!.asList()!);
  }

  static void remove(String key) {
    _mmkv.removeValue(key);
  }

  static void removeList(List<String> key) {
    _mmkv.removeValues(key);
  }

  static void clear() {
    _mmkv.clearAll();
  }
}
