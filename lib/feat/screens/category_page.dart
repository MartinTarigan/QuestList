import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/task_container.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';
import 'package:questlist/feat/screens/add_todo_page.dart';
import 'package:questlist/feat/screens/category_todo_list.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = "/category_page";
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ToDoCubitProvider>().updateUIForCategory(category);
    });
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        var todaysToDos =
            context.read<ToDoCubitProvider>().getCategoryTodaysToDos(category);
        return Scaffold(
          backgroundColor: BaseColors.neutral,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Column(
                  children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                color: Colors.white
                                                    .withOpacity(0.3),
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
                    )
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          TotalToDoCategory(
                        category: category,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(
                        milliseconds: 300,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BaseColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: BaseColors.primaryBlue,
                              ),
                              child: const Icon(
                                Icons.folder_rounded,
                                color: BaseColors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total ToDo",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                Text(
                                  category.todoList.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: BaseColors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Today ToDo",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount:
                        todaysToDos.where((todo) => !todo.isCompleted).length,
                    itemBuilder: (context, index) {
                      todaysToDos = todaysToDos
                          .where((todo) => !todo.isCompleted)
                          .toList();
                      return ToDoContainer(
                        todo: todaysToDos[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            height: 50,
            child: FloatingActionButton(
              backgroundColor: BaseColors.purple,
              splashColor: BaseColors.primaryBlue,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AddToDoPage.routeName,
                  arguments: category,
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add New ToDo",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: BaseColors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.edit,
                    color: BaseColors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
