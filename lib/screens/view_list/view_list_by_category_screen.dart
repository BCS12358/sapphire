import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/models/reminder/reminder.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/screens/widgets/dissmissable_background.dart';
import 'package:sapphire/services/database_service.dart';

import '../../models/category/category.dart';

class ViewListByCategoryScreen extends StatelessWidget {
  final Category category;

  const ViewListByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);

    final reminderForCategory = allReminders
        .where((reminder) =>
            reminder.categoryId == category.id || category.id == 'all')
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
          itemCount: reminderForCategory.length,
          itemBuilder: (context, index) {
            final reminder = reminderForCategory[index];
            return Dismissible(
              key: UniqueKey(),
              background: const DissmissableBackground(),
              onDismissed: (direction) async {
                final user = Provider.of<User?>(context);
                final todoListForReminder = Provider.of<List<TodoList>>(context)
                    .firstWhere(
                        (todoList) => todoList.id == reminder.list['id']);

                DatabaseService(uid: user!.uid)
                    .deleteReminder(reminder, todoListForReminder);
              },
              child: Card(
                child: ListTile(
                  title: Text(reminder.title),
                ),
              ),
            );
          }),
    );
  }
}
