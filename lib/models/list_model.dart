import 'package:list_manager/models/list_item_model.dart';

class ListModel {
  String _title;
  String _description;
  List<ListItemModel> _items;

  ListModel(title, description, {items}) {
    this._title = title;
    this._description = description;
    this._items = items ?? List<ListItemModel>();
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

  ListItemModel getItem(int index) => _items[index];

  void addItem(ListItemModel list) => _items.add(list);

  void deleteItemById(int index) => _items.removeAt(index);

  void deleteItemByValue(ListItemModel item) => _items.remove(item);

  void updateItem(int index, {String title, String description, bool isDone}) {
    _items[index]
        .update(title: title, description: description, isDone: isDone);
  }

  void update({String title, String description}) {
    this._title = title ?? this._title;
    this._description = description ?? this._description;
  }
}
