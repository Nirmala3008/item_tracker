import 'package:flutter/foundation.dart';

import 'item_model.dart';

class ItemProvider with ChangeNotifier {
  List<Item> itemsList = [];

  void addItem(Item item) {
    itemsList.add(item);
    notifyListeners();
  }

  void editItem(int id, Item newItem) {
    itemsList[id] = newItem;
    notifyListeners();
  }

  void removeItem(int id) {
    itemsList.removeAt(id);
    notifyListeners();
  }
}
