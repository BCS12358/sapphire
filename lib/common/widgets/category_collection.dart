import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/category/category.dart';
import 'category_icon.dart';

class CategoryCollection {
  final List<Category> _categories = [
    Category(
        id: 'today',
        name: 'today',
        categoryIcon: const CategoryIcon(
          bgColor: CupertinoColors.systemBlue,
          iconData: CupertinoIcons.calendar_today,
        )),
    Category(
        id: 'schedule',
        name: 'Schedule',
        categoryIcon: const CategoryIcon(
          bgColor: CupertinoColors.systemRed,
          iconData: CupertinoIcons.calendar,
        )),
    Category(
        id: 'all',
        name: 'All',
        categoryIcon: const CategoryIcon(
          bgColor: CupertinoColors.systemGreen,
          iconData: Icons.inbox_rounded,
        )),
    Category(
        id: 'flagged',
        name: 'Flagged',
        categoryIcon: const CategoryIcon(
          bgColor: CupertinoColors.systemOrange,
          iconData: CupertinoIcons.flag_fill,
        )),
  ];

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  Category removeAt(int index) {
    return _categories.removeAt(index);
  }

  void insert(index, item) {
    _categories.insert(index, item);
  }

  List<Category> get selectedCategories {
    return _categories.where((element) => element.isChecked).toList();
  }
}
