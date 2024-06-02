import 'package:shared_preferences/shared_preferences.dart';

class ChacheHelper {
  static late SharedPreferences sharedPreferences;

  //* Here we initialize the cache
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //* Method to put the data in local database using key

  String? getDataString({
    required String key,
  }) {
    return sharedPreferences.getString(key);
  }

  //* this method to put data in local database using key

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

//* this method to get data already saved in local database

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

//* remove data using specific key

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

//* this method to check if local database contains {key}
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  // Future<bool> clearData({required String key}) async {
  //   return sharedPreferences.clear();
  // }
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

//* this used to put data in local data base using key
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }

  //! New

  // Add a method to save the image URL to SharedPreferences
  Future<void> saveImageUrl(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImageUrl', imageUrl);
  }

// Add a method to get the image URL from SharedPreferences
  Future<String?> getImageUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profileImageUrl');
  }
}
