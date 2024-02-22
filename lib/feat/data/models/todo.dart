class Category {
  String title;
  List<ToDo> todoList;

  Category({
    required this.title,
    List<ToDo>? todoList,
  }) : todoList = todoList ?? [];

  @override
  String toString() {
    return 'Category(title: $title, todoList: $todoList)';
  }
}

class ToDo {
  static int todoID = 1; 
  int id;
  String title;
  String? startDate;
  String? endDate;
  String? dateRange;
  String? description;

  ToDo({
    required this.title,
    this.startDate,
    this.endDate,
    this.description,
  }) : id = todoID++; 
}
