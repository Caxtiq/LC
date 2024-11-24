import 'package:flutter/material.dart';
import 'package:flutterswing/states/to_do_state.dart';
import 'package:provider/provider.dart';

class TodoListComponent extends StatelessWidget {
  final String pageId;
  final TextEditingController _controller = TextEditingController();

  TodoListComponent({required this.pageId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoState>(
      builder: (context, todoState, child) {
        final todos = todoState.pageTodos[pageId] ?? [];

        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text('Todo List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add a new task',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      final text = _controller.text;
                      if (text.isNotEmpty) {
                        todoState.addTodo(pageId, text);
                        _controller.clear();
                      }
                    },
                  ),
                ),
                onSubmitted: (text) {
                  if (text.isNotEmpty) {
                    todoState.addTodo(pageId, text);
                    _controller.clear();
                  }
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => todoState.toggleTodo(pageId, todo.id),
                      ),
                      title: Text(
                        todo.task,
                        style: TextStyle(
                          decoration: todo.completed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => todoState.removeTodo(pageId, todo.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}