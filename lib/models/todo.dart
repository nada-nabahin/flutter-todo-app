class Todo {
  String title;
  bool isDone;

  Todo({required this.title, required this.isDone});

  Map<String, dynamic> toJson() {
    return {'title': title, 'isDone': isDone};
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json['title'], isDone: json['isDone']);
  }
}
