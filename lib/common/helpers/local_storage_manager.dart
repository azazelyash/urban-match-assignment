import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:urban_match_task/common/helpers/local_storage_key_manager.dart';

class LocalStorageManager {
  final FlutterSecureStorage secureStorage;

  LocalStorageManager({required this.secureStorage});

  Future<void> saveAccessToken({required String token}) async {
    try {
      log("Access Token Saved", name: "Save Token");
      await secureStorage.write(
        key: LocalStorageKeys.accessToken.asString,
        value: token,
      );
    } catch (error) {
      log(error.toString(), name: "Save Token Error");
      rethrow;
    }
  }

  Future<String?> getAccessToken() async {
    try {
      final token = await secureStorage.read(
        key: LocalStorageKeys.accessToken.asString,
      );
      if (token != null) {
        log(token, name: "Access Token");
        return token;
      } else {
        throw "Access Token Not Found!";
      }
    } catch (e) {
      log(e.toString(), name: "Get Token Error");
      return null;
    }
  }

  Future<void> clearUserData() async {
    try {
      await secureStorage.deleteAll();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
