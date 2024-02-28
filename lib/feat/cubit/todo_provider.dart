import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';
import 'package:questlist/feat/global/todo_list.dart';

class ToDoCubitProvider extends Cubit<ToDoState> {
  ToDoCubitProvider() : super(ToDoInitial());

  void addCategory(Category category) {
    ToDoList.categoryList.add(category);
    emit(CategoryListUpdated(List.from(ToDoList.categoryList)));
  }

  Category getCategory(Category category) {
    return ToDoList.categoryList.firstWhere((elem) => elem == category);
  }

  List<ToDo> getCategoryTodaysToDos(Category category) {
    var targetedCategory = getCategory(category);
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
    Category category,
    String? date,
    String? start,
    String? end,
    String notes,
  ) {
    ToDo todo = ToDo(
      category: category,
      title: title,
      date: date,
      start: start,
      end: end,
      notes: notes,
    );
    addToDo(category, todo);
    emit(ToDoDataLoaded());
  }

  void editToDo(
    ToDo todo,
    String newTitle,
    String newDate,
    String newStart,
    String newEnd,
    String newNotes,
  ) {
    todo.title = newTitle;
    todo.date = newDate;
    todo.start = newStart;
    todo.end = newEnd;
    todo.notes = newNotes;
  }

  void addToDo(Category category, ToDo todo) {
    Category targetedCategory = getCategory(category);
    targetedCategory.todoList.add(todo);
    emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
  }

  void deleteToDo(ToDo todo) {
    Category targetedCategory = getCategory(todo.category);
    Future.delayed(
      Duration(seconds: 2),
      () {
        print("a");
        targetedCategory.todoList.remove(todo);
        emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
      },
    );

  }

  void markAsCompleted(ToDo todo) {
    todo.isCompleted = true;
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
      default:
        return getCompletedToDos();
    }
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
}
