import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todos/core/theme/base_color.dart';
import 'package:Todos/feat/cubit/interaction.dart';
import 'package:Todos/feat/cubit/todo_provider.dart';
import 'package:Todos/feat/data/models/dashboard_item.dart';
import 'package:Todos/feat/data/models/todo.dart';
import 'package:Todos/feat/screens/add_todo_page.dart';
import 'package:Todos/feat/screens/category_page.dart';
import 'package:Todos/core/widgets/navbar.dart';
import 'package:Todos/feat/screens/category_todo_list.dart';
import 'package:Todos/feat/screens/dashboard_page.dart';
import 'package:Todos/feat/screens/edit_todo.dart';
import 'package:Todos/feat/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToDoCubitProvider>(
          create: (context) => ToDoCubitProvider(),
        ),
        BlocProvider<InteractionCubit>(
          create: (context) => InteractionCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'QuestList',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: BaseColors.black,
              fontFamily: "Poppins",
            ),
          ),
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          PersistentBottomNavPage.routeName: (context) =>
              PersistentBottomNavPage(),
          CategoryPage.routeName: (context) => CategoryPage(
              category: ModalRoute.of(context)?.settings.arguments as Category),
          AddToDoPage.routeName: (context) => AddToDoPage(
                category:
                    ModalRoute.of(context)?.settings.arguments as Category,
              ),
          EditToDoPage.routeName: (context) => EditToDoPage(
                todo: ModalRoute.of(context)?.settings.arguments as ToDo,
              ),
          TotalToDoCategory.routeName: (context) => TotalToDoCategory(
                category:
                    ModalRoute.of(context)?.settings.arguments as Category,
              ),
          DashboardPage.routeName: (context) => DashboardPage(
                item: ModalRoute.of(context)?.settings.arguments as Item,
              ),
          SplashScreen.routeName: (context) => const SplashScreen(),
        },
      ),
    );
  }
}
