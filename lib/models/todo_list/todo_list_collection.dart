import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';

class TodoListCollection with ChangeNotifier {
  List<TodoList> _todoList = [];

  UnmodifiableListView<TodoList> get todoList =>
      UnmodifiableListView(_todoList);

  addTodoList(TodoList todoList) {
    _todoList.add(todoList);
    notifyListeners();
  }

  removeTodoList(TodoList todoList) {
    _todoList.removeWhere((tl) => tl.id == todoList.id);
    notifyListeners();
  }
}
