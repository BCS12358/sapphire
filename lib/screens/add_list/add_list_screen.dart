import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/common/helpers/helpers.dart' as helpers;
import 'package:sapphire/models/common/custom_color.dart';
import 'package:sapphire/models/common/custom_color_collection.dart';
import 'package:sapphire/models/common/custom_item.dart';
import 'package:sapphire/models/common/custom_item_collection.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/services/database_service.dart';

class AddListScreen extends StatefulWidget {
  static String routeName = '/addList';

  const AddListScreen({Key? key}) : super(key: key);

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  CustomColor _selectedCustomColor = CustomColorCollection().colors.first;
  CustomItem _selectedCustomIcon = CustomItemCollection().cutomItems.first;

  TextEditingController _textEditingController = TextEditingController();
  String _listName = '';

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        print(_textEditingController.text);
        _listName = _textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New List'),
        actions: [
          TextButton(
              onPressed: _listName.isEmpty
                  ? null
                  : () async {
                      final user = Provider.of<User?>(context, listen: false);

                      final newTodoList = TodoList(
                          id: null,
                          title: _textEditingController.text,
                          icon: {
                            'id': _selectedCustomIcon.id,
                            'color': _selectedCustomColor.id
                          },
                          reminderCount: 0);

                      try {
                        DatabaseService(uid: user!.uid)
                            .addTodoList(todoList: newTodoList);

                        helpers.showSnackBar(context, 'Todo list created');
                      } catch (e) {
                        helpers.showSnackBar(
                            context, 'Unable to create todo list');
                      }

                      Navigator.pop(context);
                    },
              child: Text(
                'Add',
                style: TextStyle(
                    color:
                        _listName.isNotEmpty ? Colors.blueAccent : Colors.grey),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedCustomColor.color,
                    ),
                    child: Icon(_selectedCustomIcon.icon, size: 50),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _textEditingController.clear();
                          },
                          icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: const Icon(Icons.clear)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    // todo: widget candidate?
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final cc in CustomColorCollection().colors)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCustomColor = cc;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: cc.id == _selectedCustomColor.id
                                    ? Border.all(color: Colors.white, width: 5)
                                    : null,
                                shape: BoxShape.circle,
                                color: cc.color),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    // todo: widget candidate?
                    spacing: 10,
                    runSpacing: 15,
                    children: [
                      for (final ci in CustomItemCollection().cutomItems)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCustomIcon = ci;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: ci.id == _selectedCustomIcon.id
                                    ? Border.all(color: Colors.white, width: 5)
                                    : null,
                                shape: BoxShape.circle,
                                color: Colors.grey.shade900),
                            child: Icon(ci.icon),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
