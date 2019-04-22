import 'package:flutter_redux_practice/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_redux_practice/model/item_model.dart';

@immutable
class AppState {
  final List<Item> items;
  final User user;

  const AppState({@required this.items, @required this.user});
//  AppState.initialState()
//      : items = List.unmodifiable(<Item>[]);


  factory AppState.initial(){
    print('Initializing app state');
    return AppState(
        items: [],
        user : User.initial()
    );
  }

  AppState copyWith({
    Item items,
    User user
  }){
    return AppState(
      items: items ?? this.items, user: user ?? this.user,
    );
  }

  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((i) => Item.fromJson(i)).toList(), user = (User.fromJson(json['user']));

  Map toJson() => {'items': items, 'user' : user};

  @override
  String toString() {
    return toJson().toString();
  }
}