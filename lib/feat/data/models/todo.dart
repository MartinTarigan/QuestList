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
  String title;

  ToDo({
    required this.title,
  });
}
