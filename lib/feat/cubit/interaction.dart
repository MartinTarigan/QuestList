import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todos/core/theme/base_color.dart';

class InteractionCubit extends Cubit<InteractionState> {
  InteractionCubit() : super(InitDataState(BaseColors.primaryBlue, 3, 7 ~/ 2));
  void toggleButton(
      {Color color = BaseColors.primaryBlue,
      int selectedColorIndex = 3,
      int selectedDateIndex = 3}) {
    emit(InitDataState(color, selectedColorIndex, selectedDateIndex));
  }
}

abstract class InteractionState {}

class InitDataState extends InteractionState {
  final Color selectedColor;
  final int selectedColorIndex;
  final int selectedDateIndex;

  InitDataState(
      this.selectedColor, this.selectedColorIndex, this.selectedDateIndex);
}
