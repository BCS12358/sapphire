import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';

class SelectReminderListScreen extends StatelessWidget {
  final List<TodoList> todoList;
  final TodoList selectedTodoList;
  final Function(TodoList) selectListCallBack;

  const SelectReminderListScreen(
      {super.key,
      required this.todoList,
      required this.selectedTodoList,
      required this.selectListCallBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select List'),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final item = todoList[index];
            return ListTile(
              onTap: () {
                selectListCallBack(item);
                Navigator.pop(context);
              },
              title: Text(item.title),
              trailing: item.title == selectedTodoList.title
                  ? const Icon(Icons.check)
                  : null,
            );
          }),
    );
  }
}
