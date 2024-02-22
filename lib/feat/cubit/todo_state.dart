import 'package:questlist/feat/data/models/todo.dart';

// todo_state.dart

abstract class ToDoState {}

class ToDoInitial extends ToDoState {
  @override
  String toString() => 'ToDoInitial';
}

class ToDoListLoading extends ToDoState {
  @override
  String toString() => 'ToDoListLoading';
}

class ToDoListUpdated extends ToDoState {
  final List<Category> category;

  ToDoListUpdated(this.category);

  @override
  String toString() => 'ToDoListUpdated { todos: $category }';
}

class ToDoListError extends ToDoState {
  final String error;

  ToDoListError(this.error);

  @override
  String toString() => 'ToDoListError { error: $error }';
}
