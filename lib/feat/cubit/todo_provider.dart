import 'package:bloc/bloc.dart';
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

  List<ToDo> getTodaysToDos(Category category) {
    var targetedCategory = getCategory(category);
    var today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    var todaysToDos = targetedCategory.todoList
        .where((todo) => todo.date?.split(" - ")[0] == today)
        .toList();
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

  void addToDo(Category category, ToDo todo) {
    Category targetedCategory = getCategory(category);
    targetedCategory.todoList.add(todo);
    emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
  }

  void deleteToDo(ToDo todo) {
    Category targetedCategory = getCategory(todo.category);
    targetedCategory.todoList.remove(todo);
    emit(ToDoListUpdated(List.from(targetedCategory.todoList)));
  }

  void updateUIForCategory(Category category) {
    var todaysToDos = getTodaysToDos(category);
    emit(TodaysToDoListUpdated(todaysToDos));
  }
}
