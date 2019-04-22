import 'package:flutter/foundation.dart';

@immutable
class User {
  final int id;
  final String name;
  final bool authenticated;

  User({@required this.id, @required this.name, this.authenticated = false});

  factory User.initial() {
    return null;
  }

  User copyWith({int id, String name, bool authenticated}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        authenticated: authenticated ?? this.authenticated);
  }

  User.fromJson(Map json)
      : name = json['name'],
        id = json['id'],
        authenticated = json['authenticated'];

  Map toJson() =>
      {'id': (id), 'name': name, 'authenticated': authenticated};

  @override
  String toString() {
    return toJson().toString();
  }
}
