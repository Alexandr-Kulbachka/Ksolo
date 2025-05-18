import 'package:flutter/cupertino.dart';
import '../../models/task_model.dart';

class TasksService extends ChangeNotifier {
  late List<TaskModel> _tasks;

  TasksService() {
    _tasks = <TaskModel>[];
  }

  get size => _tasks.length;

  TaskModel getTask(index) => _tasks[index];

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateList(index, {String? title, String? description}) {
    if (title != null || description != null) {
      _tasks[index].update(title: title, description: description);
      notifyListeners();
    }
  }
}
