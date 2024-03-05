import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todos/core/constant/assets.dart';
import 'package:Todos/core/constant/profile.dart';
import 'package:Todos/core/constant/typography.dart';
import 'package:Todos/core/theme/base_color.dart';
import 'package:Todos/core/widgets/todo_dashboard.dart';
import 'package:Todos/feat/cubit/todo_provider.dart';
import 'package:Todos/feat/cubit/todo_state.dart';
import 'package:Todos/feat/global/todo_list.dart';
import 'package:Todos/feat/screens/category_page.dart';

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
          return SingleChildScrollView(
            child: Stack(
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
                        bottom: 20,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    AssetImage(Assets.profilePhoto),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Welcome,',
                                    style: TextStyle(
                                      color: Color(0xFFC8BFF9),
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
                          Expanded(
                            child: SizedBox(
                              height: 48,
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, top: 15, bottom: 6),
                      child: Text('Your Todos', style: Font.heading1),
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
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                        bottom: 6,
                      ),
                      child: Text(
                        "Your Categories",
                        style: Font.heading2,
                      ),
                    ),
                    categoryList.isEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.emptyList,
                                  scale: 7,
                                ),
                                Text(
                                  "Your Category List is Empty",
                                  style: Font.heading3,
                                )
                              ],
                            )),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 166,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 15),
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                final category = categoryList[index];
                                return Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: category.color,
                                  ),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          left: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 125,
                                              child: Text(
                                                category.title,
                                                style: Font.primaryBodyLarge,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Text(
                                                category.todoList.isEmpty
                                                    ? "0 task"
                                                    : category.todoList
                                                                .length ==
                                                            1
                                                        ? "1 tasks"
                                                        : "${category.todoList.length} tasks",
                                                style: Font.primaryBodySmall,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Navigator.pushNamed(
                                                  context,
                                                  CategoryPage.routeName,
                                                  arguments: category),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5,
                                                    horizontal: 20,
                                                  ),
                                                  color: BaseColors.purple,
                                                  child: Text(
                                                    'Detail',
                                                    style:
                                                        Font.primaryBodyMedium,
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                                  color: BaseColors.red,
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                        size: 100,
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
            ),
          );
        },
      ),
    );
  }
}
