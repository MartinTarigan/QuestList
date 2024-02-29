import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/constant/profile.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/todo_dashboard.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/global/todo_list.dart';
import 'package:questlist/feat/screens/category_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.neutral,
      body: BlocBuilder<ToDoCubitProvider, ToDoState>(
        builder: (context, state) {
          var categoryList = ToDoList.categoryList;

          if (state is CategorySearchState) {
            categoryList = state.filteredCategories;
          }
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
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: BaseColors.primaryBlue),
                              child: Text(
                                Developer.name.substring(0, 1),
                                style: Font.primaryBodyLarge,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    color: BaseColors.tertiaryGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  Developer.nickname,
                                  style: Font.primaryBodyLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 48,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) =>
                                BlocProvider.of<ToDoCubitProvider>(context)
                                    .searchCategories(value),
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: const InputDecoration(
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
                                borderSide:
                                    BorderSide(color: Color(0xFFF7F8F9)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              hintText: 'Search Categories',
                            ),
                          ),
                        ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 25, left: 25, top: 20, bottom: 10),
                    child: Text('Your Quest', style: Font.heading1),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    child: Text(
                      "Your Categories",
                      style: Font.heading2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        final category = categoryList[index];
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
                                        style: Font.primaryBodyLarge,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        category.todoList.isEmpty
                                            ? "0 task"
                                            : category.todoList.length == 1
                                                ? "1 tasks"
                                                : "${category.todoList.length} tasks",
                                        style: Font.primaryBodySmall,
                                      ),
                                    ),
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
                                          child: Text(
                                            'Detail',
                                            style: Font.primaryBodyMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () => context
                                          .read<ToDoCubitProvider>()
                                          .deleteCategory(category),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                          color: BaseColors.red,
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
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
}
