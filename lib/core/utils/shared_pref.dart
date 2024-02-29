import 'package:questlist/feat/data/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static Future<void> saveCategories(List<Category> categories) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String categoriesJson =
        jsonEncode(categories.map((category) => category.toJson()).toList());
    await prefs.setString('categories', categoriesJson);
  }

  static Future<List<Category>> loadCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      List<dynamic> decodedJson = json.decode(categoriesJson);
      List<Category> categories =
          decodedJson.map((json) => Category.fromJson(json)).toList();
      return categories;
    } else {
      return [];
    }
  }
}
