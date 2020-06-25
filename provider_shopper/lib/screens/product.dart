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
      'oldPrice': FieldValue.serverTimestamp(),
      'newPrice': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<List<ProductModel>>(context);
    debugPrint(products.toString());

    return Scaffold(
      body: Container(
        child: Text(
          products[products.length -1 ].name,
          style: TextStyle(fontWeight: FontWeight.bold),
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
