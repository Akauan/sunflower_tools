import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  SharedData._();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Function that saves data securely on the device using key and value
  static Future saveSecureData(String key, String value) async {
    var dataSaved = await _prefs!.setString(key, value);
    return dataSaved;
  }

  // // Function that securely reads data from the device using key and value
  static Future readSecureData(String key) async {
    var data = _prefs!.getString(key);
    return data;
  }

  // // function that checks if a user is already logged in
  static Future<bool> isLogged() async {
    try {
      var data = _prefs!.getString('farm');
      if (data == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  // // Function that deletes all data
  static Future clearDatas() async {
    var data = await _prefs!.clear();
    return data;
  }

  // // Function that deletes an specific instance of data
  // static Future deleteData(String key) async {
  //   var data = await _storage.delete(key: key);
  //   return data;
  // }
}
