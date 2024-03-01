import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/input.dart';
import 'package:questlist/feat/cubit/interaction.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/data/models/todo.dart';

class FABHomePage extends StatelessWidget {
  FABHomePage({super.key});

  final TextEditingController titleController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: BaseColors.neutral,
          title: Text(
            'Add Category',
            style: Font.heading2,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        formKey: formKey,
                        controller: titleController,
                        label: 'Title',
                        autoFocus: true,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                BlocBuilder<InteractionCubit, CategoryColorSelected>(
                  builder: (context, state) {
                    return Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: BaseColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: colorButtons.length,
                        itemBuilder: (context, index) {
                          bool isSelected = index == state.selectedIndex;
                          ColorButton colorButton = colorButtons[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<InteractionCubit>()
                                  .toggleButton(colorButton.color, index);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: isSelected
                                        ? BaseColors.secondaryGrey
                                        : Colors.transparent,
                                  ),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  padding: const EdgeInsets.all(9),
                                  width: 35.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    color: colorButton.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                titleController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  final selectedColor =
                      context.read<InteractionCubit>().state.selectedColor;
                  context.read<ToDoCubitProvider>().addCategory(
                        Category(
                          title: titleController.text,
                          color: selectedColor,
                        ),
                      );
                  titleController.clear();
                }
              },
              child: const Text('Done'),
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

class ColorButton {
  final Color color;

  ColorButton(this.color);
}

List<ColorButton> colorButtons = [
  ColorButton(BaseColors.orange),
  ColorButton(BaseColors.yellow),
  ColorButton(BaseColors.green),
  ColorButton(BaseColors.primaryBlue),
  ColorButton(BaseColors.brown),
];
