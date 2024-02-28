import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/input.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/data/models/todo.dart';

class FABHomePage extends StatefulWidget {
  const FABHomePage({super.key});

  @override
  State<FABHomePage> createState() => _FABHomePageState();
}

class _FABHomePageState extends State<FABHomePage> {
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(
                    formKey: formKey,
                    controller: titleController,
                    label: 'Title',
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  context.read<ToDoCubitProvider>().addCategory(
                      Category(title: titleController.text.trim()));
                  titleController.clear();
                }
              },
              child: const Text('OKAY'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                titleController.clear();
              },
              child: const Text('CLOSE'),
            ),
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
