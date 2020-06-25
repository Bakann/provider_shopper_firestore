import 'package:flutter/foundation.dart';

class UserModel with DiagnosticableTreeMixin{
  String name;
  String age;

  UserModel({this.name, this.age});

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'] as String,
        age = parsedJSON['age'] as String;
}