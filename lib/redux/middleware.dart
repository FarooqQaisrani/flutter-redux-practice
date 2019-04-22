import 'dart:async';
import 'dart:convert';

import 'package:flutter_redux_practice/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_redux_practice/redux/actions.dart';

List<Middleware<AppState>> appStateMiddleware([AppState state =  const AppState( items: [], user: null)]) {
  final loadItems = _loadFromPrefs(state);
  final saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
    TypedMiddleware<AppState, AddUserAction>(saveItems),
  ];
}


Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    loadFromPrefs().then((state)  {
      store.dispatch(LoadedItemsAction(state.items));
      store.dispatch(LoadedUserAction(state.user));
//      print('in middleware ${state.user}');
    });
  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  };
}

void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
//  print('in saveToPrefs  $string');
  await preferences.setString('itemsState', string);
}



Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.get('itemsState');

//  print('in loadFromPrefs  $string');

  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initial();
}
