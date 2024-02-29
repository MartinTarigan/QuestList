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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'todoList': todoList.map((todo) => todo.toJson()).toList(),
      };

  static Category fromJson(Map<String, dynamic> json) => Category(
        title: json['title'],
        todoList: (json['todoList'] as List)
            .map((item) => ToDo.fromJson(item))
            .toList(),
      );
}

class ToDo {
  static int todoID = 1;
  int id;
  int categoryID;
  String title;
  String? start;
  String? end;
  String? date;
  String? notes;
  bool isCompleted;
  bool isChecked;

  ToDo({
    required this.title,
    required this.categoryID,
    this.start,
    this.end,
    this.date,
    this.notes,
    this.isCompleted = false,
    this.isChecked = false,
  }) : id = todoID++;

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryID': categoryID,
        'title': title,
        'start': start,
        'end': end,
        'date': date,
        'notes': notes,
        'isCompleted': isCompleted,
        'isChecked': isChecked,
      };

  static ToDo fromJson(Map<String, dynamic> json) => ToDo(
        title: json['title'],
        categoryID: json['categoryID'] ?? 0,
        start: json['start'],
        end: json['end'],
        date: json['date'],
        notes: json['notes'],
        isCompleted: json['isCompleted'],
        isChecked: json['isChecked'],
      );
}
