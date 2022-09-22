import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/common/helpers/helpers.dart' as helpers;
import 'package:sapphire/models/reminder/reminder.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/screens/widgets/dissmissable_background.dart';
import 'package:sapphire/services/database_service.dart';

class ViewListScreen extends StatelessWidget {
  final TodoList todoList;
  const ViewListScreen({Key? key, required this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);

    final remindersForList = allReminders
        .where((reminder) => reminder.list['id'] == todoList.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(todoList.title)),
      body: ListView.builder(
          itemCount: remindersForList.length,
          itemBuilder: (context, index) {
            final reminder = remindersForList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: const DissmissableBackground(),
              onDismissed: (direction) async {
                final user = Provider.of<User?>(context, listen: false);

                try {
                  await DatabaseService(uid: user!.uid)
                      .deleteReminder(reminder, todoList);
                  helpers.showSnackBar(context, 'Reminder deleted');
                } catch (e) {
                  helpers.showSnackBar(context, 'Unable to delete reminder');
                }
              },
              child: Card(
                child: ListTile(
                  title: Text(reminder.title),
                  subtitle:
                      reminder.notes != null ? Text(reminder.notes!) : null,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(helpers.formatDate(reminder.dueDate)),
                      Text(helpers.formatTime(context, reminder.dueTime['hour'],
                          reminder.dueTime['minute']))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
