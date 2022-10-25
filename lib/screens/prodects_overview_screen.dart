import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/prodect_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '/screens/cart_screen.dart';
// import 'package:provider/provider.dart';
// import '../providers/products.dart';

enum FilterOptions{
  Favorites,
  All,
}

class ProdectOverviewScreen extends StatefulWidget {

  @override
  State<ProdectOverviewScreen> createState() => _ProdectOverviewScreenState();
}

class _ProdectOverviewScreenState extends State<ProdectOverviewScreen> {
  var _showOnlyFavorites=false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer=Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title:Text('MyShop'),
        actions: <Widget> [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue==FilterOptions.Favorites){
                  // productsContainer.showFavoritesOnly();
                  _showOnlyFavorites=true;
                }else{
                  // productsContainer.showOnly();
                  _showOnlyFavorites=false;
                }
              });
            },
            icon:const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_)=>[
              const PopupMenuItem(
                  child: Text('only Favorites'),
                  value:FilterOptions.Favorites),
              const PopupMenuItem(
                  child: Text('Show all'),
                  value:FilterOptions.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_,cart,ch)=>Badge(
              child:  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      icon: const Icon(
                      Icons.shopping_cart,
                        ),
                        ),
              value:cart.itemCount.toString(),

          ),

          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

