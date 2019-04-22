import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_practice/config.dart';
import 'package:flutter_redux_practice/redux/app_state.dart';
import 'package:flutter_redux_practice/screens/dashboard/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_redux_practice/redux/actions.dart';
import 'package:flutter_redux_practice/redux/reducers.dart';
import 'package:flutter_redux_practice/redux/middleware.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

const IP = 'localhost:8000';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var remoteDevtools = RemoteDevToolsMiddleware(IP);
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
        appStateReducer,
        initialState: AppState.initial(),
        middleware: appStateMiddleware()..addAll([remoteDevtools]));

    remoteDevtools.store = store;
    remoteDevtools.connect();

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case (Routes.root):
              return MyCustomRoute(
                builder: (_) => StoreBuilder<AppState>(
                      onInit: (store)  {store.dispatch(GetItemsAction());},
                      builder: (BuildContext context, Store<AppState> store) =>
                          MyHomePage(store),
                    ),
                settings: settings,
              );

            case (Routes.detail):
              return MyCustomRoute(
                builder: (_) => MyHomePage(store),
                settings: settings,
              );
          }
        },

//        home: StoreBuilder<AppState>(
//          onInit: (store) => store.dispatch(GetItemsAction()),
//          builder: (BuildContext context, Store<AppState> store) =>
//              MyHomePage(store),
//        ),
      ),
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

//  @override
//  Duration get transitionDuration => const Duration(milliseconds: 800);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
  }
}
