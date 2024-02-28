import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/feat/data/models/todo.dart';

class InteractionCubit extends Cubit<bool> {
  InteractionCubit() : super(false);

  void toggleButton(ToDo todo) async {
    todo.isChecked = !todo.isChecked;
    await Future.delayed(const Duration(seconds: 1));
    todo.isCompleted = todo.isChecked;
    emit(todo.isCompleted);
  }
}
