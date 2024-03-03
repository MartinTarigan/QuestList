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
    if (todo.isCompleted) {
      ToDoList.completedToDoList.add(todo);
    }
    targetedCategory.todoList.remove(todo);
    await SharedPreferencesHelper.saveCategories(ToDoList.categoryList);
    emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
  }

  void markAsCompleted(ToDo todo) async {
    todo.isChecked = !todo.isChecked;
    await Future.delayed(const Duration(seconds: 1));
    todo.isCompleted = todo.isChecked;
    emit(ToDoMarkedAsCompleted(todo));
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

  List<ToDo> getDashboardToDoList(String listName) {
    switch (listName) {
      case "All":
        return getAllToDo();
      case "Today":
        return getTodaysToDo();
      case "Scheduled":
        return getScheduledToDos();
      case "Completed":
        return ToDoList.completedToDoList;
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

  List<ToDo> getToDosByDate(int index, DateTime currentDate) {
    DateTime selectedDate = currentDate.add(Duration(days: index - 3));
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

    List<ToDo> filteredTodos = getAllToDo()
        .where((todo) => todo.date?.split(" - ")[0] == formattedDate)
        .toList();

    return filteredTodos;
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

  List<DateTime> getDateRange() {
    DateTime currentDate = DateTime.now();
    List<DateTime> dateRange = [];

    for (int i = -3; i <= 3; i++) {
      dateRange.add(currentDate.add(Duration(days: i)));
    }
    return dateRange;
  }
}
