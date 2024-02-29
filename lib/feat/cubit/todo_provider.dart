import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questlist/core/utils/shared_pref.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';
import 'package:questlist/feat/global/todo_list.dart';

class ToDoCubitProvider extends Cubit<ToDoState> {
  ToDoCubitProvider() : super(ToDoInitial()) {
    loadCategories();
  }

  List<Category>? originalCategoryList;

  Future<void> loadCategories() async {
    List<Category> categories = await SharedPreferencesHelper.loadCategories();
    ToDoList.categoryList = categories;
    emit(CategoryListUpdated(List.from(categories)));
  }

  void addCategory(Category category) async {
    ToDoList.categoryList.add(category);
    await SharedPreferencesHelper.saveCategories(ToDoList.categoryList);
    emit(CategoryListUpdated(List.from(ToDoList.categoryList)));
  }

  void deleteCategory(Category category) async {
    ToDoList.categoryList.remove(category);
    await SharedPreferencesHelper.saveCategories(ToDoList.categoryList);
    emit(CategoryListUpdated(List.from(ToDoList.categoryList)));
  }

  Category getCategory(int categoryID) {
    return ToDoList.categoryList.firstWhere((elem) => elem.id == categoryID);
  }

  List<ToDo> getCategoryTodaysToDos(Category category) {
    var targetedCategory = getCategory(category.id);
    var today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    var todaysToDos = targetedCategory.todoList
        .where((todo) => todo.date?.split(" - ")[0] == today)
        .toList();

    emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
    return todaysToDos;
  }

  void getToDoData(
    BuildContext context,
    String title,
    int categoryID,
    String? date,
    String? start,
    String? end,
    String notes,
  ) {
    ToDo todo = ToDo(
      categoryID: categoryID,
      title: title,
      date: date,
      start: start,
      end: end,
      notes: notes,
    );
    addToDo(categoryID, todo);
    emit(ToDoDataLoaded());
  }

  void editToDo(
    ToDo todo,
    String newTitle,
    String newDate,
    String newStart,
    String newEnd,
    String newNotes,
  ) async {
    todo.title = newTitle;
    todo.date = newDate;
    todo.start = newStart;
    todo.end = newEnd;
    todo.notes = newNotes;
    await SharedPreferencesHelper.saveCategories(ToDoList.categoryList);
  }

  void addToDo(int categoryId, ToDo todo) async {
    Category targetedCategory = getCategory(categoryId);
    targetedCategory.todoList.add(todo);
    await SharedPreferencesHelper.saveCategories(ToDoList.categoryList);
    emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
  }

  void deleteToDo(ToDo todo) async {
    Category targetedCategory = getCategory(todo.categoryID);
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        targetedCategory.todoList.remove(todo);
        await SharedPreferencesHelper.saveCategories(ToDoList.categoryList);
        emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
      },
    );
  }

  void updateUIForCategory(Category category) {
    var todaysToDos = getCategoryTodaysToDos(category);
    emit(TodaysToDoListUpdated(todaysToDos));
  }

  List<ToDo> getTodaysToDo() {
    var today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return ToDoList.categoryList
        .expand((category) => category.todoList)
        .where(
            (todo) => todo.date?.split(" - ")[0] == today && !todo.isCompleted)
        .toList();
  }

  List<ToDo> getAllToDo() {
    return ToDoList.categoryList
        .expand((category) => category.todoList)
        .where((todo) => !todo.isCompleted)
        .toList();
  }

  List<ToDo> getCompletedToDos() {
    return ToDoList.categoryList
        .expand((category) => category.todoList)
        .where((todo) => todo.isCompleted)
        .toList();
  }

  List<ToDo> getDashboardToDoList(String listName) {
    switch (listName) {
      case "All":
        return getAllToDo();
      case "Today":
        return getTodaysToDo();
      case "Scheduled":
        return getScheduledToDos();
      case "Completed":
        return getCompletedToDos();
      default:
        return [];
    }
  }

  List<ToDo> updateDashboardToDoList(String listName) {
    List<ToDo> todoList = getDashboardToDoList(listName);
    emit(DashboardToDoListUpdated(todoList));
    return todoList;
  }

  List<ToDo> getScheduledToDos() {
    var todos = getAllToDo();
    todos.sort((a, b) {
      var dateA = DateFormat('dd/MM/yyyy').parse(a.date!.split(" - ")[0]);
      var dateB = DateFormat('dd/MM/yyyy').parse(b.date!.split(" - ")[0]);
      return dateA.compareTo(dateB);
    });
    return todos;
  }

  void searchCategories(String searchText) {
    var filteredList = searchText.isEmpty
        ? ToDoList.categoryList
        : ToDoList.categoryList
            .where((category) =>
                category.title.toLowerCase().contains(searchText.toLowerCase()))
            .toList();

    emit(CategorySearchState(filteredCategories: filteredList));
  }
}
