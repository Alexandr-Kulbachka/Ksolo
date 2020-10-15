class ListItemModel {
  String _title;
  String _description;
  bool _isDone;

  ListItemModel(title, description, {isDone = false}) {
    this._title = title;
    this._description = description;
    this._isDone = isDone;
  }

  String get title => _title;
  set title(String value) {
    _title = value;
  }

  String get description => _description;
  set description(String value) {
    _description = value;
  }

  bool get isDone => _isDone;
  set isDone(bool value) {
    _isDone = value;
  }

  void update({String title, String description, bool isDone}) {
    this._title = title ?? this._title;
    this._description = description ?? this._description;
    this._isDone = isDone ?? this._isDone;
  }
}
