import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/feat/data/models/todo.dart';
import 'package:questlist/feat/global/todo_list.dart';
import 'package:questlist/core/widgets/input.dart';
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
          return SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    color: BaseColors.purple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: BaseColors.primaryBlue),
                                  child: const Text(
                                    'M',
                                    style: TextStyle(color: Colors.white),
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
                                      'Martin Marcelino',
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: BaseColors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 90,
                                      color: BaseColors.primaryGrey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: BaseColors.primaryBlue,
                                                ),
                                                child: const Icon(
                                                    Icons.calendar_today),
                                              ),
                                              Text(
                                                ToDoList.categoryList.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600,
                                                    color: BaseColors.black),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            "Today",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 139, 137, 137),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 90,
                                      color: BaseColors.primaryGrey,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 90,
                                      color: BaseColors.primaryGrey,
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 90,
                                      color: BaseColors.primaryGrey,
                                    ),
                                  )
                                ],
                              ),
                            ],
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: BaseColors.primaryBlue,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          child: Text(category
                                                      .todoList.length <=
                                                  1
                                              ? "0 task"
                                              : "${category.todoList.length} tasks"),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, CategoryPage.routeName,
                                              arguments: category),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
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
                ),
              ],
            ),
          );
        },
      ),

      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     height: 70,
      //     padding: const EdgeInsets.all(12),
      //     margin: const EdgeInsets.symmetric(horizontal: 24),
      //     decoration: BoxDecoration(
      //       color: BaseColors.white,
      //       borderRadius: BorderRadius.circular(24),
      //     ),
      //     child: const Row(
      //       children: [
      //         Icon(Icons.list_alt),
      //         Icon(Icons.person_2_rounded),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildSearch(context) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width / 1.5,
      child: const TextField(
        readOnly: true,
        textAlignVertical: TextAlignVertical.bottom,
        // onTap: () => Navigator.of(context).push(
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) =>
        //         const SearchRestoPage(),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) {
        //       return FadeTransition(
        //         opacity: animation,
        //         child: child,
        //       );
        //     },
        //     transitionDuration: const Duration(
        //       milliseconds: 300,
        //     ),
        //   ),
        // ),
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

class FAB extends StatefulWidget {
  const FAB({
    super.key,
  });

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  TextEditingController titleController = TextEditingController();

  void displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: InputField(
            controller: titleController,
            label: "Category Name",
            maxLines: 1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<ToDoCubitProvider>()
                    .addCategory(Category(title: titleController.text));
                titleController.clear();
              },
              child: const Text('OKAY'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: FloatingActionButton(
        splashColor: BaseColors.primaryBlue,
        backgroundColor: BaseColors.purple,
        onPressed: () {
          displayDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: BaseColors.white,
        ),
      ),
    );
  }
}
