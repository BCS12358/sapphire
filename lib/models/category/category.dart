import 'package:sapphire/common/widgets/category_icon.dart';

class Category {
  String id;
  String name;
  bool isChecked;
  CategoryIcon categoryIcon;

  Category(
      {required this.id,
      required this.name,
      this.isChecked = true,
      required this.categoryIcon});

  void toggleCheckbox() {
    isChecked = !isChecked;
  }
}
