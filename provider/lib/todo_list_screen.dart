import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo.dart';
import 'todo_provider.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todos = todoProvider.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List App'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.isDone,
              onChanged: (value) {
                todoProvider.toggleTodoStatus(index);
              },
            ),
            onLongPress: () {
              todoProvider.deleteTodo(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context, todoProvider);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoProvider todoProvider) {
    final TextEditingController todoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: todoController,
            decoration: InputDecoration(hintText: 'Enter your todo...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTodo = todoController.text;
                if (newTodo.isNotEmpty) {
                  todoProvider.addTodo(newTodo);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
