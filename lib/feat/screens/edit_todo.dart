import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/fab_todo.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/core/widgets/input.dart';
import 'package:questlist/feat/data/models/todo.dart';

class EditToDoPage extends StatefulWidget {
  static const routeName = "/edit_todo";
  final ToDo todo;
  const EditToDoPage({super.key, required this.todo});

  @override
  State<EditToDoPage> createState() => _EditToDoPagePageState();
}

class _EditToDoPagePageState extends State<EditToDoPage> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController notesController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController startTimeController = TextEditingController();
  late TextEditingController endTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTimeRange? pickedDate;
  TimeOfDay? pickedStartTime;
  TimeOfDay? pickedEndTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    notesController = TextEditingController(text: widget.todo.notes);
    dateController = TextEditingController(text: widget.todo.date);
    startTimeController = TextEditingController(text: widget.todo.start);
    endTimeController = TextEditingController(text: widget.todo.end);
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: BaseColors.black.withOpacity(0.3),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: BaseColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            child: Text(
                              "Edit ToDo",
                              style: Font.heading2,
                            ),
                          ),
                        ),
                        const Opacity(
                          opacity: 0.0,
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 30,
                    ),
                    InputField(
                      controller: titleController,
                      label: "Title",
                      maxLines: 1,
                      formKey: formKey,
                    ),
                    InputField(
                      controller: dateController,
                      label: "Date",
                      maxLines: 1,
                      readOnly: true,
                      onTap: () async {
                        pickedDate = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                              start: DateTime.now(),
                              end: DateTime.now().add(const Duration(days: 1))),
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime(DateTime.now().year + 5),
                        );
                        if (pickedDate != null) {
                          dateController.text =
                              "${DateFormat('dd/MM/yyyy').format(pickedDate!.start)} - ${DateFormat('dd/MM/yyyy').format(pickedDate!.end)}";
                        }
                      },
                      formKey: formKey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: InputField(
                            controller: startTimeController,
                            label: "Start Time",
                            maxLines: 1,
                            readOnly: true,
                            onTap: () async {
                              pickedStartTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedStartTime != null) {
                                startTimeController.text =
                                    "${pickedStartTime!.hour}:${pickedStartTime!.minute.toString().padLeft(2, '0')}";
                              }
                            },
                            formKey: formKey,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: InputField(
                            controller: endTimeController,
                            label: "End Time",
                            maxLines: 1,
                            readOnly: true,
                            onTap: () async {
                              pickedEndTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedEndTime != null) {
                                endTimeController.text =
                                    "${pickedEndTime!.hour}:${pickedEndTime!.minute.toString().padLeft(2, '0')}";
                              }
                            },
                            formKey: formKey,
                          ),
                        ),
                      ],
                    ),
                    InputField(
                      controller: notesController,
                      label: "Notes",
                      maxLines: 4,
                      formKey: formKey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FABToDo(
            buttonName: "Edit",
            onTap: () {
              context.read<ToDoCubitProvider>().editToDo(
                    widget.todo,
                    titleController.text,
                    dateController.text,
                    startTimeController.text,
                    endTimeController.text,
                    notesController.text,
                  );
              widget.todo.title = titleController.text;

              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
