import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/common/theme.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/screens/cart.dart';
import 'package:provider_shopper/screens/catalog.dart';
import 'package:provider_shopper/screens/login.dart';
import 'package:provider_shopper/screens/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/product.dart';
import 'models/user.dart';

Future<void> main() async {
  runApp(MyApp(firestore: Firestore.instance));
}

class MyApp extends StatelessWidget {
  final Firestore firestore;

  MyApp({this.firestore});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        StreamProvider(
          initialData: List<ProductModel>(),
          create: (_) => Firestore.instance.collection('products').snapshots().map(
              (snapShot) => snapShot.documents
                  .map((document) => ProductModel.fromMap(document.data))
                  .toList()),
          child: CatalogPage(),
        ),
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => CatalogPage(),
          '/cart': (context) => MyCart(),
          '/products': (context) => Product(),
        },
      ),
    );
  }
}
