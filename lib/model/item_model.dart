import 'package:flutter/foundation.dart';

@immutable
class Item {
  final int id;
  final String body;
  final bool completed;

  Item({@required this.id, @required this.body, this.completed = false});



  factory Item.initial(){
    return Item(id: null, body: null);

  }

  Item copyWith({int id, String body, bool completed}) {
    return Item(
        id: id ?? this.id,
        body: body ?? this.body,
        completed: completed ?? this.completed);
  }

  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'],
        completed = json['completed'];

  Map toJson() => {'id': (id), 'body': body, 'completed': completed};

  @override
  String toString() {
    return toJson().toString();
  }
}