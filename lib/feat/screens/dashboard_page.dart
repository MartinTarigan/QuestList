import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/task_container.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';

class DashbordPage extends StatelessWidget {
  static const routeName = "/dashboard_page";
  final String listName;
  const DashbordPage({super.key, required this.listName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        var todoList =
            context.read<ToDoCubitProvider>().getDashboardToDoList(listName);

        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  color: BaseColors.purple,
                  padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: MediaQuery.of(context).padding.top,
                    bottom: 30,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: BaseColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 30,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: BaseColors.neutral,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final todo = todoList[index];
                      return ToDoContainer(todo: todo);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
