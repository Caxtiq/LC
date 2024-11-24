import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoState extends ChangeNotifier {
  Map<String, List<TodoItem>> pageTodos = {};

  void addTodo(String pageId, String task) {
    if (!pageTodos.containsKey(pageId)) {
      pageTodos[pageId] = [];
    }
    pageTodos[pageId]!.add(TodoItem(id: Uuid().v4(), task: task));
    notifyListeners();
  }

  void toggleTodo(String pageId, String id) {
    final todos = pageTodos[pageId];
    if (todos != null) {
      final index = todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        todos[index] = todos[index].copyWith(completed: !todos[index].completed);
        notifyListeners();
      }
    }
  }

  void removeTodo(String pageId, String id) {
    pageTodos[pageId]?.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
class TodoItem {
  final String id;
  final String task;
  final bool completed;

  TodoItem({required this.id, required this.task, this.completed = false});

  TodoItem copyWith({String? id, String? task, bool? completed}) {
    return TodoItem(
      id: id ?? this.id,
      task: task ?? this.task,
      completed: completed ?? this.completed,
    );
  }
}