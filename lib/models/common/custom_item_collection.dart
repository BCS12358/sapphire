import 'package:collection/collection.dart';

import 'package:flutter/cupertino.dart';
import 'package:sapphire/models/common/custom_item.dart';

class CustomItemCollection {
  final List<CustomItem> _customItems = [
    CustomItem(id: "bars", icon: CupertinoIcons.bars),
    CustomItem(id: "alarm", icon: CupertinoIcons.alarm),
    CustomItem(id: "airplane", icon: CupertinoIcons.airplane),
    CustomItem(id: "person", icon: CupertinoIcons.person),
    CustomItem(id: "calendar", icon: CupertinoIcons.calendar),
    CustomItem(id: "star", icon: CupertinoIcons.star),
  ];

  UnmodifiableListView<CustomItem> get cutomItems =>
      UnmodifiableListView(_customItems);

  CustomItem? findCustomItembyId(id) =>
      _customItems.firstWhereOrNull((ci) => ci.id == id);
}
