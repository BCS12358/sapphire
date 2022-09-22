import 'package:flutter/material.dart';
import 'package:sapphire/common/widgets/category_collection.dart';
import 'package:sapphire/models/category/category.dart';

class SelectReminderCategoryScreen extends StatelessWidget {
  final Category selectedCategory;
  final Function(Category) selectedCategoryCallBack;

  const SelectReminderCategoryScreen(
      {super.key,
      required this.selectedCategory,
      required this.selectedCategoryCallBack});

  @override
  Widget build(BuildContext context) {
    var _categories = CategoryCollection().categories;
    return Scaffold(
      appBar: AppBar(title: const Text('Select Cateogry')),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          final item = _categories[index];
          if (item.id == 'all') {
            return Container();
          }
          return ListTile(
            onTap: () {
              selectedCategoryCallBack(item);
              Navigator.pop(context);
            },
            title: Text(item.name),
            trailing:
                item.name == selectedCategory.name ? Icon(Icons.check) : null,
          );
        },
      ),
    );
  }
}
