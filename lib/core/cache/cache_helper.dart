import 'package:shared_preferences/shared_preferences.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'dart:convert';

class ChacheHelper {
  static late SharedPreferences sharedPreferences;

  //* Here we initialize the cache
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    //! nurse preference and user

    bool isDarkTheme = sharedPreferences.getBool('isDarkTheme') ?? false;
    print("Initial theme preference: $isDarkTheme");
    if (!sharedPreferences.containsKey('isDarkTheme')) {
      await sharedPreferences.setBool('isDarkTheme', false);
    }
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

  //! Cart Pref

  //* Save list of Medicine objects
  Future<void> saveMedicineCartItems(List<Medicine> medicines) async {
    List<String> jsonMedicines =
        medicines.map((medicine) => json.encode(medicine.toJson())).toList();
    await sharedPreferences.setStringList('medicineCartItems', jsonMedicines);
  }

  //* Get list of Medicine objects
  List<Medicine> getMedicineCartItems() {
    List<String>? jsonMedicines =
        sharedPreferences.getStringList('medicineCartItems');
    if (jsonMedicines != null) {
      return jsonMedicines
          .map((jsonMedicine) => Medicine.fromJson(json.decode(jsonMedicine)))
          .toList();
    }
    return [];
  }

  //* Save list of LabTestModel objects
  Future<void> saveLabTestCartItems(List<LabTestModel> labTests) async {
    List<String> jsonLabTests =
        labTests.map((labTest) => json.encode(labTest.toJson())).toList();
    await sharedPreferences.setStringList('labTestCartItems', jsonLabTests);
  }

  //* Get list of LabTestModel objects
  List<LabTestModel> getLabTestCartItems() {
    List<String>? jsonLabTests =
        sharedPreferences.getStringList('labTestCartItems');
    if (jsonLabTests != null) {
      return jsonLabTests
          .map((jsonLabTest) => LabTestModel.fromJson(json.decode(jsonLabTest)))
          .toList();
    }
    return [];
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

  //* Save theme preference
  Future<void> saveThemePreference(bool isDarkTheme) async {
    print("Saving theme preference: $isDarkTheme");
    await sharedPreferences.setBool('isDarkTheme', isDarkTheme);
  }

  //* Get theme preference
  bool getThemePreference() {
    return sharedPreferences.getBool('isDarkTheme') ?? false;
  }

  //* Remove theme preference
  Future<bool> removeThemePreference() async {
    return await sharedPreferences.remove('isDarkTheme');
  }
}
