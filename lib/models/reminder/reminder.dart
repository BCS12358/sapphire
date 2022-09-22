class Reminder {
  String? id;
  final String title;
  final String? notes;
  final String categoryId;
  final Map<String, dynamic> list;
  final int dueDate;
  final Map<String, dynamic> dueTime; // {hours: 10, minutes: 12}

  Reminder(
      {required this.id,
      required this.title,
      this.notes,
      required this.categoryId,
      required this.list,
      required this.dueDate,
      required this.dueTime});

  Reminder.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        notes = json['notes'],
        categoryId = json['category_id'],
        list = json['list'],
        dueDate = json['due_date'],
        dueTime = json['due_time'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'notes': notes,
        'category_id': categoryId,
        'list': list,
        'due_date': dueDate,
        'due_time': dueTime
      };
}
