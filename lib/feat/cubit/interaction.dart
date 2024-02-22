import 'package:flutter_bloc/flutter_bloc.dart';

class InteractionCubit extends Cubit<bool> {
  InteractionCubit() : super(false); 

  void toggleButton() => emit(!state); 
}
