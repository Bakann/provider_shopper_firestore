import 'package:cloud_firestore/cloud_firestore.dart';

/// the convenience class that holds a single record for a name.
/// You don't strictly need this class for a simple app like this to function,
/// but it makes the code a bit cleaner.
class ProductModel {
  String name;
  String oldPrice;
  String newPrice;
  String documentID;

  final DocumentReference reference;

  ProductModel.fromMap(DocumentSnapshot documentSnapshot, {this.reference})
      : name = documentSnapshot.data['name'] as String,
        newPrice = documentSnapshot.data['newPrice'] as String,
        oldPrice = documentSnapshot.data['oldPrice'] as String,
        documentID = documentSnapshot.documentID;
}
