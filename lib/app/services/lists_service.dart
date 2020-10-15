import 'package:flutter/cupertino.dart';
import 'package:list_manager/models/list_model.dart';

class ListService extends ChangeNotifier {
  List<ListModel> _lists;

  ListService() {
    _lists = List<ListModel>();
  }

  get size => _lists.length;

  ListModel getList(index) => _lists[index];

  void addList(ListModel list) {
    if (list != null) {
      _lists.add(list);
      notifyListeners();
    } else {
      throw Exception("The list to add must not be null.");
    }
  }

  void updateList(index, {String title, String description}) {
    if (title != null || description != null) {
      _lists[index].update(title: title, description: description);
      notifyListeners();
    } else {
      throw Exception(
          "You must pass at least one non-null value to update the list.");
    }
  }
}
