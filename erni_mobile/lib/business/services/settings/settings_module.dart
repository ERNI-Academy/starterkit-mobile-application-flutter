// coverage:ignore-file

import 'package:erni_mobile/dependency_injection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SettingsModule {
  @lazySingleton
  @preResolve
  @running
  Future<SharedPreferences> getSharedPreferences() => SharedPreferences.getInstance();

  @lazySingleton
  @running
  FlutterSecureStorage getFlutterSecureStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }
}
