import '../models/task_item_model.dart';

class TaskModel {
  late String _title;
  late String _description;
  late List<TaskItemModel> _items;

  TaskModel(title, description, {items}) {
    _title = title;
    _description = description;
    _items = items ?? <TaskItemModel>{};
  }

  String get title => _title;
  set title(String value) {
    _title = value;
  }

  String get description => _description;
  set description(String value) {
    _description = value;
  }

  get size => _items.length;

  TaskItemModel getItem(int index) => _items[index];

  void addItem(TaskItemModel task) => _items.add(task);

  void deleteItemById(int index) => _items.removeAt(index);

  void deleteItemByValue(TaskItemModel item) => _items.remove(item);

  void updateItem(int index, {String? title, String? description, bool? done}) {
    _items[index].update(title: title, description: description, done: done);
  }

  void update({String? title, String? description}) {
    if (title != null) _title = title;
    if (description != null) _description = description;
  }
}
