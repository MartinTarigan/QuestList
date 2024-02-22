import 'package:bloc/bloc.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';
import 'package:questlist/feat/global/todo_list.dart';

class ToDoCubitProvider extends Cubit<ToDoState> {
  ToDoCubitProvider() : super(ToDoInitial());

  void addCategory(Category category) {
    ToDoList.categoryList.add(category);
    emit(ToDoListUpdated(List.from(ToDoList.categoryList)));
  }
}

