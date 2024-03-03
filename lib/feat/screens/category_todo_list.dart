import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todos/core/constant/assets.dart';
import 'package:Todos/core/constant/typography.dart';
import 'package:Todos/core/theme/base_color.dart';
import 'package:Todos/core/widgets/task_container.dart';
import 'package:Todos/feat/cubit/todo_provider.dart';
import 'package:Todos/feat/cubit/todo_state.dart';
import 'package:Todos/feat/data/models/todo.dart';

class TotalToDoCategory extends StatefulWidget {
  static const routeName = "/total_todo";
  final Category category;
  const TotalToDoCategory({super.key, required this.category});

  @override
  State<TotalToDoCategory> createState() => _TotalToDoCategoryState();
}

class _TotalToDoCategoryState extends State<TotalToDoCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        final sortedTodoList = List<ToDo>.from(widget.category.todoList)
          ..sort(
            (a, b) {
              if (!a.isCompleted && b.isCompleted) {
                return -1;
              } else if (a.isCompleted && !b.isCompleted) {
                return 1;
              }
              return 0;
            },
          );
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
                                    widget.category.title,
                                    style: Font.primaryBodyLarge,
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
                    "${widget.category.title}'s ToDo List",
                    style: Font.heading2,
                  ),
                ),
                sortedTodoList.isEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                Assets.emptyList,
                                scale: 6,
                              ),
                              Text(
                                "Your ToDo List is Empty",
                                style: Font.heading3,
                              )
                            ],
                          ),
                        ),
                      )
                    : Expanded(
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
