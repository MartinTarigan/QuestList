import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/task_container.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';

class TotalToDoCategory extends StatelessWidget {
  static const routeName = "/total_todo";
  final Category category;
  const TotalToDoCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        final sortedTodoList = List<ToDo>.from(category.todoList)
          ..sort((a, b) {
            if (!a.isCompleted && b.isCompleted) {
              return -1; 
            } else if (a.isCompleted && !b.isCompleted) {
              return 1; 
            }
            return 0; 
          });

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: BaseColors.primaryBlue,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 160,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5.0, sigmaY: 5.0),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            color: BaseColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    category.title,
                                    style: const TextStyle(
                                        color: BaseColors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.list_alt_rounded,
                        size: 110,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "${category.title}'s ToDo List",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: sortedTodoList.length,
                    itemBuilder: (context, index) {
                      final todo = sortedTodoList[index];
                      return ToDoContainer(todo: todo);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
