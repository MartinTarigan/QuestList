import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:Todos/core/theme/base_color.dart';
import 'package:Todos/core/widgets/task_container.dart';
import 'package:Todos/feat/cubit/interaction.dart';
import 'package:Todos/feat/cubit/todo_provider.dart';
import 'package:Todos/feat/cubit/todo_state.dart';
import 'package:Todos/feat/data/models/todo.dart';

class CalendarPage extends StatelessWidget {
  static const routeName = "/calendar_page";

  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    List<DateTime> dateRange = context.read<ToDoCubitProvider>().getDateRange();

    return CalendarView(dateRange: dateRange, currentDate: currentDate);
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({
    super.key,
    required this.dateRange,
    required this.currentDate,
  });

  final List<DateTime> dateRange;
  final DateTime currentDate;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteractionCubit, InteractionState>(
        builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            height: 70,
            width: double.infinity,
            child: Align(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final date = widget.dateRange[index];
                  int selectedIndex = 0;
                  if (state is InitDataState) {
                    selectedIndex = state.selectedDateIndex;
                  }
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<InteractionCubit>()
                          .toggleButton(selectedDateIndex: index);
                      context
                          .read<ToDoCubitProvider>()
                          .getToDosByDate(index, widget.currentDate);
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? BaseColors.primaryBlue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: BaseColors.secondaryGrey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('d').format(date),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ToDoCubitProvider, ToDoState>(
              builder: (context, state) {
                List<ToDo> filteredToDoList =
                    state is TodosFilteredByDate ? state.filteredTodos : [];
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: filteredToDoList.length,
                  itemBuilder: (context, index) {
                    final todo = filteredToDoList[index];
                    return ToDoContainer(todo: todo);
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
