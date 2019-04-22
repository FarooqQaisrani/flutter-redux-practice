import 'package:flutter_redux_practice/model/item_model.dart';
import 'package:flutter_redux_practice/model/user_model.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id++;
  }

  int get id => _id;

  toJson() {
    return {'id': this.id, 'item' : this.item};
  }
}

class RemoveItemAction {
  final Item item;
  RemoveItemAction(this.item);

  toJson() {
    return {'item' : this.item};
  }
}

class RemoveItemsAction {}

class GetItemsAction {}
class LoadedItemsAction {
  final List<Item> items;
  LoadedItemsAction(this.items);

  toJson() {
    return {'items' : this.items};
  }
}

class ItemCompletedAction {
  final Item item;

  ItemCompletedAction(this.item);

  toJson() {
    return {'item' : this.item};
  }
}


class AddUserAction {
  final User user;
  AddUserAction(this.user);

  toJson() {
    return {'user': this.user};
  }
}

class RemoveUserAction {
}

class LoadedUserAction{
  final User user;
  LoadedUserAction(this.user);
  toJson() {
    return {'user': this.user};
  }
}