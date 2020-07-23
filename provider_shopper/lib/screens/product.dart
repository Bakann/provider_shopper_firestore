import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/product.dart';
import 'package:provider_shopper/models/user.dart';

/// categories
///
class Product extends StatelessWidget {

  CollectionReference get products => Firestore.instance.collection('products');

  Future<void> _addMessage() async {
    await products.add(<String, dynamic>{
      'name': 'Hello world!',
//      'oldPrice': FieldValue.serverTimestamp(),
//      'newPrice': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductArguments args = ModalRoute.of(context).settings.arguments as ProductArguments;

    return Scaffold(
      body: Container(
        child: StreamProvider(
          create: (_) => Firestore.instance
              .collection('products')
              .document(args.documentID)
              .snapshots()
              .map(
                  (snapShot) => ProductModel.fromMap(snapShot)),
          child: ProductDescription(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add product',
        child: Icon(Icons.add),
        onPressed: _addMessage,
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<ProductModel>(context);

    return Text('Hi ${product.name}');
  }

}

class ProductArguments {
  final String documentID;
  final String name;

  ProductArguments(this.documentID, this.name);
}