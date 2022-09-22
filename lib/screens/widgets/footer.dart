import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/screens/add_list/add_list_screen.dart';
import 'package:sapphire/screens/add_reminder/add_reminder_screen.dart';

import '../../models/todo_list/todo_list_collection.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            icon: const Icon(Icons.add_circle),
            onPressed: todoLists.length > 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddReminderScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  }
                : null,
            label: const Text("New Reminder"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddListScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text("Add List"),
          ),
        ],
      ),
    );
  }
}
