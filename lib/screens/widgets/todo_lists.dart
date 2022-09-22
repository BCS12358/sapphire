import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/common/helpers/helpers.dart' as helpers;
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/screens/widgets/dissmissable_background.dart';
import 'package:sapphire/services/database_service.dart';

import '../../common/widgets/category_icon.dart';
import '../../models/common/custom_color_collection.dart';
import '../../models/common/custom_item_collection.dart';
import '../view_list/view_list_screen.dart';

class TodoLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final todoList = Provider.of<List<TodoList>>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My List',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: const DissmissableBackground(),
                    onDismissed: (direction) async {
                      try {
                        await DatabaseService(uid: user!.uid)
                            .deleteTodoList(todoList[index]);
                        // ignore: use_build_context_synchronously
                        helpers.showSnackBar(context, 'Todo list deleted');
                      } catch (e) {
                        helpers.showSnackBar(
                            context, 'Unable to delete Todo List');
                      }
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewListScreen(
                                      todoList: todoList[index])));
                        },
                        leading: CategoryIcon(
                            bgColor: (CustomColorCollection().findColorById(
                                    todoList[index].icon['color']))
                                ?.color,
                            iconData: CustomItemCollection()
                                .findCustomItembyId(todoList[index].icon['id'])
                                ?.icon),
                        title: Text(todoList[index].title),
                        trailing: Text(todoList[index].reminderCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
