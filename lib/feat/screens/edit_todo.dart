import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
          appBar: AppBar(
            title: const Text("Edit Todo"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InputField(
                      controller: titleController,
                      label: "Title",
                      maxLines: 1,
                      formKey: formKey,
                      autoFocus: true,
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
