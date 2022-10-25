import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/cart.dart';

import './screens/cart_screen.dart';
import './screens/prodects_overview_screen.dart';
import './screens/products_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() =>runApp( MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
        // value: Products(),
        create: (context)=>Products(),
        ),
        ChangeNotifierProvider(
        // value: Products(),
        create: (context)=>Cart(),
        ),
        ChangeNotifierProvider(
          create: (context)=>Orders(),
        ),
        ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily:'Lato',
        ),
        home:  ProdectOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductDetailScreen.routeName:(context)=>ProductDetailScreen(),
          CartScreen.routeName:(context)=>CartScreen(),
          OrdersScreen.routeName:(context)=>OrdersScreen(),
          UserProductsScreen.routeName:(context)=>UserProductsScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen(),

        },
      ),
    );

  }
}

