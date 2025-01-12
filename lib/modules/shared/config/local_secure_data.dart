import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecureData {
  LocalSecureData._();

  // Initializing SecureStorage
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Function that saves data securely on the device using key and value
  static Future saveSecureData(String key, String value) async {
    var dataSaved = await _storage.write(key: key, value: value);
    return dataSaved;
  }

  // Function that securely reads data from the device using key and value
  static Future readSecureData(String key) async {
    var data = await _storage.read(key: key);
    return data;
  }

  // function that checks if a user is already logged in
  static Future<bool> isLogged() async {
    try {
      var data = await _storage.read(key: 'farm');
      if (data == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  // Function that deletes all data
  static Future clearDatas() async {
    var data = await _storage.deleteAll();
    return data;
  }

  // Function that deletes an specific instance of data
  static Future deleteData(String key) async {
    var data = await _storage.delete(key: key);
    return data;
  }
}
