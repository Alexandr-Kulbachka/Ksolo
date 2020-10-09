import 'package:list_manager/models/list_item_model.dart';

class ListModel {
  String _title;
  String _description;
  List<ListItemModel> items;

  ListModel(title, description, {items}) {
    this._title = title;
    this._description = description;
    this.items = items ?? List<ListItemModel>();
  }

  String get title => _title;
  set title(String value) {
    _title = value;
  }

  String get description => _description;
  set description(String value) {
    _description = value;
  }
}
