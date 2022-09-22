import 'package:flutter/material.dart';
import 'package:sapphire/models/common/custom_color.dart';
import 'package:collection/collection.dart';

class CustomColorCollection {
  List<CustomColor> _colors = [
    CustomColor(id: 'amber', color: Colors.amber),
    CustomColor(id: 'blue', color: Colors.blue),
    CustomColor(id: 'red', color: Colors.red),
    CustomColor(id: 'green', color: Colors.green),
    CustomColor(id: 'purple', color: Colors.purple),
    CustomColor(id: 'orange', color: Colors.deepOrange),
  ];

  UnmodifiableListView<CustomColor> get colors => UnmodifiableListView(_colors);

  CustomColor? findColorById(id) => _colors.firstWhereOrNull((c) => c.id == id);
}
