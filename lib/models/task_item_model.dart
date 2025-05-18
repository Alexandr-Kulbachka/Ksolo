class TaskItemModel {
  late String _title;
  late String _description;
  late bool _done;

  TaskItemModel(title, description, {isDone = false}) {
    _title = title;
    _description = description;
    _done = isDone;
  }

  String get title => _title;
  set title(String value) {
    _title = value;
  }

  String get description => _description;
  set description(String value) {
    _description = value;
  }

  bool get done => _done;
  set done(bool value) {
    _done = value;
  }

  void update({String? title, String? description, bool? done}) {
    _title = title ?? _title;
    _description = description ?? _description;
    _done = done ?? _done;
  }
}
