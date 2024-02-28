import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/constant/profile.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/todo_dashboard.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/global/todo_list.dart';
import 'package:questlist/feat/screens/category_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home_page";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.neutral,
      body: BlocBuilder<ToDoCubitProvider, ToDoState>(
        builder: (context, state) {
          var todayToDos = ToDoList.categoryList;
          return Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.width,
                  color: BaseColors.purple,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 25,
                        top: MediaQuery.of(context).padding.top,
                        bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: BaseColors.primaryBlue),
                          child: Text(
                            Developer.name.substring(0, 1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome,',
                                style: TextStyle(
                                  color: BaseColors.primaryGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                )),
                            Text(
                              Developer.nickname,
                              style: TextStyle(
                                color: BaseColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSearch(context),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: BaseColors.primaryBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.filter_alt_rounded,
                            ),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 25, left: 25, top: 20, bottom: 10),
                    child: Text(
                      'Your Quest',
                      style: TextStyle(
                        color: BaseColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: const Dashboard(),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    child: Text(
                      "Your Categories",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: BaseColors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: todayToDos.length,
                      itemBuilder: (context, index) {
                        final category = todayToDos[index];
                        return Container(
                          width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: BaseColors.primaryBlue,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        category.title,
                                        style: const TextStyle(
                                            color: BaseColors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        child: Text(category.todoList.isEmpty
                                            ? "0 tasks"
                                            : category.todoList.length == 1
                                                ? "1 task"
                                                : "${category.todoList.length} tasks")),
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, CategoryPage.routeName,
                                          arguments: category),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                          color: BaseColors.purple,
                                          child: const Text(
                                            'Detail',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildSearch(context) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width / 1.5,
      child: const TextField(
        readOnly: true,
        textAlignVertical: TextAlignVertical.bottom,
        //TODO: develop search feature
        decoration: InputDecoration(
          fillColor: Color(0xFFFFFFFF),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFF7F8F9),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF7F8F9)),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          hintText: 'Search Categories',
        ),
      ),
    );
  }
}
