import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/feat/data/models/todo.dart';

class InteractionCubit extends Cubit<bool> {
  InteractionCubit() : super(false);

  void toggleButton(ToDo todo) {
    todo.isDone = !todo.isDone;
    emit(todo.isDone);
  }
}
