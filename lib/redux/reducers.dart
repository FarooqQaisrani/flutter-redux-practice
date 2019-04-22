import 'package:flutter_redux_practice/redux/app_state.dart';
import 'package:flutter_redux_practice/model/item_model.dart';
import 'package:flutter_redux_practice/model/user_model.dart';
import 'package:flutter_redux_practice/redux/actions.dart';

import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
    user: userReducer(state.user, action),
  );
}

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(itemCompletedReducer),
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action) {
  return []
    ..addAll(items)
    ..add(Item(id: action.id, body: action.item));
}

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action) {
  return List.unmodifiable(List.from(items)..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> items, RemoveItemsAction action) {
  return [];
}

List<Item> loadItemsReducer(List<Item> items, LoadedItemsAction action) {
  return action.items;
}

List<Item> itemCompletedReducer(List<Item> items, ItemCompletedAction action) {
  return items
      .map((item) => item.id == action.item.id
          ? item.copyWith(completed: !item.completed)
          : item)
      .toList();
}

//List<Item> itemReducer(List<Item> state, action) {
//
//  if(action is AddItemAction) {
//    return []..addAll(state)..add(Item(id: action.id, body: action.item));
//  }
//
//  if (action is RemoveItemAction) {
//    return List.unmodifiable(List.from(state)..remove(action.item));
//  }
//
//  if (action is RemoveItemsAction) {
//    return List.unmodifiable([]);
//  }
//
//  if (action is LoadedItemsAction) {
//    return action.items;
//  }
//
//  return state;
//
//}

Reducer<User> userReducer = combineReducers<User>([
  TypedReducer<User, AddUserAction>(addUserReducer),
  TypedReducer<User, LoadedUserAction>(loadUserReducer),
]);

User loadUserReducer(User user, LoadedUserAction action) {
//  print('in LoadedUserAction');
//  print('action.user ${action.user}');

  final newUser = action.user;
  return newUser;
}

User addUserReducer(User user, AddUserAction action) {
//  print('in AddUserAction');
//  print('action.user ${action.user}');

  final newUser = user.copyWith(id: action.user.id, name: action.user.name, authenticated: action.user.authenticated);

  return newUser;


}

User removeUserReducer(User user, AddUserAction action) {
  return null;
}