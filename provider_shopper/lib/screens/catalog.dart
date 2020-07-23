import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/models/product.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:provider_shopper/screens/product.dart';

import 'addproduct.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<List<ProductModel>>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => _MyListItem(index, products[index]),
            childCount: products.length,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add product',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(builder: (context) => AddProductPage()),
          );
        },
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  final ProductModel product;

  _MyListItem(this.index, this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: InkWell(
          onTap: ()  {
            Navigator.pushNamed(
              context,
              '/product',
              arguments: ProductArguments(
                product.documentID,
                product.name,
              ),
            );
          },
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Text(product.name, style: textTheme),
              ),
              SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
