import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/common/widgets/category_collection.dart';
import 'package:sapphire/config/custom_theme.dart';
import 'package:sapphire/screens/widgets/list_view_items.dart';
import 'package:sapphire/screens/widgets/todo_lists.dart';

import '../widgets/footer.dart';
import '../widgets/grid_view-items.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();
  String layoutType = 'grid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: (() {
              final ct = Provider.of<CustomTheme>(context, listen: false);
              ct.toogleTheme();
            }),
            icon: const Icon(Icons.wb_sunny)),
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout)),
        TextButton(
          onPressed: () {
            if (layoutType == 'grid') {
              setState(() {
                layoutType = 'list';
              });
            } else {
              setState(() {
                layoutType = 'grid';
              });
            }
          },
          child: Text(
            layoutType == 'grid' ? 'Edit' : 'Done',
          ),
        ),
      ]),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19 / 8),
          color: Colors.black,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  AnimatedCrossFade(
                    firstChild: GridViewItems(
                        categories: categoryCollection.selectedCategories),
                    secondChild:
                        ListViewItems(categoryCollection: categoryCollection),
                    crossFadeState: layoutType == 'grid'
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                  ),
                  TodoLists(),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
