import 'package:cloud_firestore/cloud_firestore.dart';

/// the convenience class that holds a single record for a name.
/// You don't strictly need this class for a simple app like this to function,
/// but it makes the code a bit cleaner.
class ProductModel {
  String name;
  String oldPrice;
  String newPrice;

  final DocumentReference reference;

  ProductModel.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'] as String,
        newPrice = map['newPrice'] as String,
        oldPrice = map['oldPrice'] as String;
}
