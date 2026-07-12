import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo.dart';

class TodoStorageService {
  static const _key = 'tasks';

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_key);

    if (tasksString == null) return [];

    final List<dynamic> decoded = jsonDecode(tasksString);
    return decoded.map((item) => Todo.fromJson(item)).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(todos.map((t) => t.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}
