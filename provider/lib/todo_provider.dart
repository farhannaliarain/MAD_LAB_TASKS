// ignore_for_file: prefer_typing_uninied_variables

import 'package:flutter/material.dart';
import 'package:provider1/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    final todo = Todo(title: title);
    _todos.add(todo);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
