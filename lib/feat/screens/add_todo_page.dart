import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:questlist/feat/cubit/todo_provider.dart';
import 'package:questlist/feat/cubit/todo_state.dart';
import 'package:questlist/core/widgets/input.dart';
import 'package:questlist/feat/data/models/todo.dart';

class AddToDoPage extends StatefulWidget {
  static const routeName = "/add_todo";
  final Category category;
  AddToDoPage({super.key, required this.category});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();

  final TextEditingController endTimeController = TextEditingController();

  DateTimeRange? pickedDate;

  TimeOfDay? pickedStartTime;

  TimeOfDay? pickedEndTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubitProvider, ToDoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Todo"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputField(
                  controller: titleController,
                  label: "Title",
                  maxLines: 1,
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
                      ),
                    ),
                  ],
                ),
                InputField(
                  controller: descriptionController,
                  label: "Notes",
                  maxLines: 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ToDoCubitProvider>().getToDoData(
                          context,
                          titleController.text,
                          widget.category,
                          dateController.text,
                          startTimeController.text,
                          endTimeController.text,
                          descriptionController.text,
                        );

                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
