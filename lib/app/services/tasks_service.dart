import 'package:flutter/cupertino.dart';
import '../../models/task_model.dart';

class TasksService extends ChangeNotifier {
  List<TaskModel> _tasks;

  TasksService() {
    _tasks = List<TaskModel>();
  }

  get size => _tasks.length;

  TaskModel getTask(index) => _tasks[index];

  void addTask(TaskModel task) {
    if (task != null) {
      _tasks.add(task);
      notifyListeners();
    } else {
      throw Exception("The list to add must not be null.");
    }
  }

  void updateList(index, {String title, String description}) {
    if (title != null || description != null) {
      _tasks[index].update(title: title, description: description);
      notifyListeners();
    } else {
      throw Exception(
          "You must pass at least one non-null value to update the list.");
    }
  }
}
