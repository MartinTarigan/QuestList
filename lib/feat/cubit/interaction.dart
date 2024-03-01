import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';

class InteractionCubit extends Cubit<CategoryColorSelected> {
  InteractionCubit() : super(CategoryColorSelected(BaseColors.primaryBlue, 3));

  void toggleButton(Color color, int index) {
    emit(CategoryColorSelected(color, index));
  }
}

class CategoryColorSelected {
  final Color selectedColor;
  final int selectedIndex;
  CategoryColorSelected(this.selectedColor, this.selectedIndex);
}
