import 'package:Todos/feat/data/models/todo.dart';
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

  static Future<void> saveCompletedToDoList(List<ToDo> completedToDoList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String completedToDoListJson = jsonEncode(completedToDoList.map((todo) => todo.toJson()).toList());
    await prefs.setString('completedToDoList', completedToDoListJson);
  }

  static Future<List<ToDo>> loadCompletedToDoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? completedToDoListJson = prefs.getString('completedToDoList');
    if (completedToDoListJson != null) {
      List<dynamic> decodedJson = json.decode(completedToDoListJson);
      List<ToDo> completedToDoList = decodedJson.map((json) => ToDo.fromJson(json)).toList();
      return completedToDoList;
    } else {
      return [];
    }
  }
}

