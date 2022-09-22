import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/common/widgets/category_collection.dart';
import 'package:sapphire/common/widgets/category_icon.dart';
import 'package:sapphire/models/category/category.dart';
import 'package:sapphire/models/reminder/reminder.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/screens/add_reminder/select_reminder_category_screen.dart';
import 'package:sapphire/screens/add_reminder/select_reminder_list_screen.dart';
import 'package:sapphire/services/database_service.dart';

class AddReminderScreen extends StatefulWidget {
  static const String routeName = '/add_reminder';

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController _noteEditingController = TextEditingController();
  TextEditingController _tileEditingController = TextEditingController();

  String _title = '';
  String _note = '';

  TodoList? _selectedList;
  Category? _selectedCategory = CategoryCollection().categories[0];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _tileEditingController.addListener(() {
      setState(() {
        _title = _tileEditingController.text;
      });
    });

    _noteEditingController.addListener(() {
      setState(() {
        _note = _noteEditingController.text;
      });
    });
  }

  _updateSelectedList(TodoList todoList) {
    setState(() {
      _selectedList = todoList;
    });
  }

  _updateSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tileEditingController.dispose();
    _noteEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _todoLists = Provider.of<List<TodoList>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
        actions: [
          TextButton(
              onPressed: _title.isEmpty ||
                      _selectedDate == null ||
                      _selectedTime == null
                  ? null
                  : () async {
                      final user = Provider.of<User?>(context, listen: false);

                      _selectedList = _todoLists.first;

                      var newReminder = Reminder(
                          id: null,
                          title: _title,
                          categoryId: _selectedCategory!.id,
                          list: _selectedList!.toJson(),
                          notes: _note,
                          dueDate: _selectedDate!.millisecondsSinceEpoch,
                          dueTime: {
                            'hour': _selectedTime!.hour,
                            'minute': _selectedTime!.minute
                          });
                      try {
                        DatabaseService(uid: user!.uid)
                            .addReminder(reminder: newReminder);
                      } catch (e) {
                        //show error
                      }
                    },
              child: const Text(
                'Add',
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _tileEditingController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                        hintText: 'Title', border: InputBorder.none),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      controller: _noteEditingController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                          hintText: 'Note', border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Theme.of(context).cardColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectReminderListScreen(
                                selectedTodoList: _selectedList != null
                                    ? _selectedList!
                                    : _todoLists.first,
                                todoList: _todoLists,
                                selectListCallBack: _updateSelectedList,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  leading: Text(
                    'List',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CategoryIcon(
                        bgColor: Colors.blueAccent,
                        iconData: Icons.calendar_today,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(_selectedList != null
                          ? _selectedList!.title
                          : _todoLists.first.title),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Theme.of(context).cardColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectReminderCategoryScreen(
                          selectedCategory: _selectedCategory!,
                          selectedCategoryCallBack: _updateSelectedCategory,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  leading: Text(
                    'Category',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                        bgColor: _selectedCategory!.categoryIcon.bgColor,
                        iconData: _selectedCategory!.categoryIcon.iconData,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(_selectedCategory!.name),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Theme.of(context).cardColor,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)));

                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  leading: Text(
                    'Date',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CategoryIcon(
                        bgColor: Colors.red,
                        iconData: CupertinoIcons.calendar_badge_plus,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(_selectedDate != null
                          ? DateFormat.yMMMEd()
                              .format(_selectedDate!)
                              .toString()
                          : 'Selected date'),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Theme.of(context).cardColor,
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime;
                      });
                    }
                  },
                  leading: Text(
                    'Time',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CategoryIcon(
                        bgColor: Colors.red,
                        iconData: CupertinoIcons.time,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(_selectedTime != null
                          ? _selectedTime!.format(context).toString()
                          : 'Select time'),
                      const Icon(Icons.arrow_forward),
                    ],
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
