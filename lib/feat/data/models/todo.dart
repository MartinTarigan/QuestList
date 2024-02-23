class Category {
  static int categoryID = 1;
  int id;
  String title;
  List<ToDo> todoList;

  Category({
    required this.title,
    List<ToDo>? todoList,
  })  : id = categoryID++,
        todoList = todoList ?? [];
}

class ToDo {
  static int todoID = 1;
  int id;
  Category category;
  String title;
  String? start;
  String? end;
  String? date;
  String? notes;
  bool isDone;

  ToDo({
    required this.title,
    required this.category,
    this.start,
    this.end,
    this.date,
    this.notes,
    this.isDone = false,
  }) : id = todoID++;
}
