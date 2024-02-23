import 'package:questlist/feat/data/models/todo.dart';

abstract class ToDoState {}

class ToDoInitial extends ToDoState {
  @override
  String toString() => 'ToDoInitial';
}

class ToDoListLoading extends ToDoState {
  @override
  String toString() => 'ToDoListLoading';
}

class ToDoDataLoaded extends ToDoState {
  @override
  String toString() => 'ToDoListLoading';
}

class CategoryListUpdated extends ToDoState {
  final List<Category> category;

  CategoryListUpdated(this.category);

  @override
  String toString() => 'CategoryListUpdated { category: $category }';
}

class ToDoListUpdated extends ToDoState {
  final List<ToDo> todo;

  ToDoListUpdated(this.todo);

  @override
  String toString() => 'ToDoListUpdated { todos: $todo }';
}

class ToDoListError extends ToDoState {
  final String error;

  ToDoListError(this.error);

  @override
  String toString() => 'ToDoListError { error: $error }';
}

class ToDoCategorySelected extends ToDoState {
  final Category category;

  ToDoCategorySelected(this.category);

  @override
  String toString() => 'ToDoCategorySelected { category: $category }';
}

class TodaysToDoListUpdated extends ToDoState {
  final List<ToDo> todaysToDos;

  TodaysToDoListUpdated(this.todaysToDos);

  @override
  String toString() => 'TodaysToDoListUpdated { todaysToDos: $todaysToDos }';
}
