import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/models/category/category.dart';
import 'package:sapphire/models/reminder/reminder.dart';
import 'package:sapphire/screens/view_list/view_list_by_category_screen.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: categories
          .map(
            (category) => InkWell(
              onTap: getCategoryCount(
                          id: category.id, allReminders: allReminders) >
                      0
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewListByCategoryScreen(
                                  category: category)));
                    }
                  : null,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19 / 8),
                  color: Colors.grey.shade800,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        category.categoryIcon,
                        Text(getCategoryCount(
                                id: category.id, allReminders: allReminders)
                            .toString()),
                      ],
                    ),
                    Text(category.name)
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  int getCategoryCount(
      {required String id, required List<Reminder> allReminders}) {
    if (id == 'all') {
      return allReminders.length;
    }

    final categories =
        allReminders.where((element) => element.categoryId == id);

    return categories.length;
  }
}
