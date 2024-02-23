import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/feat/cubit/interaction.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';

class ToDoContainer extends StatelessWidget {
  final ToDo todo;
  ToDoContainer({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        return BlocBuilder<InteractionCubit, bool>(
          builder: (context, _) {
            return Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BaseColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Text(todo.date ?? ""),
                          Text(todo.category.title)
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<InteractionCubit>().toggleButton(todo);
                          Future.delayed(
                              const Duration(seconds: 1),
                              () => context
                                  .read<ToDoCubitProvider>()
                                  .deleteToDo(todo));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: BaseColors.purple,
                              width: 2.5,
                            ),
                            color: todo.isDone
                                ? BaseColors.purple
                                : BaseColors.white,
                          ),
                          child: Icon(
                            todo.isDone ? Icons.check : null,
                            color: BaseColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: -3.5,
                  bottom: 35,
                  child: Container(
                    width: 6,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10), 
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
