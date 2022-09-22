import 'package:flutter/material.dart';

import '../../common/widgets/category_collection.dart';

const LIST_VIEW_HEIGHT = 60.0;

class ListViewItems extends StatefulWidget {
  final CategoryCollection categoryCollection;

  ListViewItems({required this.categoryCollection});

  @override
  State<ListViewItems> createState() => _ListViewItemsState();
}

class _ListViewItemsState extends State<ListViewItems> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.categoryCollection.categories.length * LIST_VIEW_HEIGHT,
      child: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = widget.categoryCollection.removeAt(oldIndex);
          setState(() {
            widget.categoryCollection.insert(newIndex, item);
          });
        },
        children: widget.categoryCollection.categories
            .map((category) => SizedBox(
                  key: UniqueKey(),
                  height: LIST_VIEW_HEIGHT,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        category.toggleCheckbox();
                      });
                    },
                    tileColor: Colors.grey.shade900,
                    leading: Container(
                      decoration: BoxDecoration(
                          color: category.isChecked
                              ? Colors.blueAccent
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: category.isChecked
                                  ? Colors.blue
                                  : Colors.grey)),
                      child: Icon(
                        Icons.check,
                        color: category.isChecked
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    title: Row(
                      children: [
                        category.categoryIcon,
                        const SizedBox(
                          width: 10,
                        ),
                        Text(category.name),
                      ],
                    ),
                    trailing: const Icon(Icons.reorder),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
