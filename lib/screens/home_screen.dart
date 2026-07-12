import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/theme/app_colors.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/todo_storage_service.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _editController = TextEditingController();
  final TodoStorageService _storageService = TodoStorageService();

  List<Todo> tasks = [];
  bool _isLoading = true;

  int get remainingTasks => tasks.where((task) => !task.isDone).length;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loaded = await _storageService.loadTodos();
    setState(() {
      tasks = loaded;
      _isLoading = false;
    });
  }

  Future<void> _saveTasks() async {
    await _storageService.saveTodos(tasks);
  }

  @override
  void dispose() {
    _taskController.dispose();
    _editController.dispose();
    super.dispose();
  }

  String get _greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$remainingTasks OF ${tasks.length} REMAINING',
              style: const TextStyle(
                letterSpacing: 2,
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$_greeting, ${widget.userName}.',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      hintStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_taskController.text.trim().isNotEmpty) {
                      setState(() {
                        tasks.add(
                          Todo(
                            title: _taskController.text.trim(),
                            isDone: false,
                          ),
                        );
                      });
                      _saveTasks();
                      _taskController.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: tasks.asMap().entries.map((entry) {
                int index = entry.key;
                Todo task = entry.value;
                return TodoItem(
                  title: task.title,
                  isDone: task.isDone,
                  onChanged: (value) {
                    setState(() {
                      task.isDone = value ?? false;
                    });
                    _saveTasks();
                  },
                  onDelete: () {
                    setState(() {
                      tasks.removeAt(index);
                    });
                    _saveTasks();
                  },
                  onEdit: () {
                    _editController.text = task.title;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.cardBackground,
                          title: const Text(
                            'Edit Task',
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          content: TextField(
                            controller: _editController,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Task',
                              labelStyle: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_editController.text.trim().isNotEmpty) {
                                  setState(() {
                                    tasks[index].title = _editController.text
                                        .trim();
                                  });
                                  _saveTasks();
                                }
                                _editController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (tasks.any((task) => task.isDone))
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      tasks.removeWhere((task) => task.isDone);
                    });
                    _saveTasks();
                  },
                  child: const Text(
                    'Clear Completed',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
