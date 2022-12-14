import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier{
  List <Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'shoes',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://www.seprun.com/media/x259/Under_Armour_UA_Curry/UA_Curry_V_5/UA_Curry_5_Under_Armour_Curry_5_High_Red_3020677-600.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Trousers',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://media.istockphoto.com/photos/blue-chino-pants-with-brown-leather-belt-isolated-on-white-background-picture-id1149139165?k=20&m=1149139165&s=612x612&w=0&h=GZNt8WgiJ3tSbVmcAKbIUmFAzbulMTw1NJ7msG2Tyno=',
    ),
    Product(
      id: 'p4',
      title: 'TV',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://www.lg.com/eg_en/images/tvs/promo-images/32LM550BPVA-M01v.jpg',
    ),
  ];
  var _showFavoritesOnly=false;

  List <Product> get items{
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List <Product> get favoriteItems{
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
  Product findById (String id){
    return _items.firstWhere((prod) => prod.id== id);
  }
  // void showFavoritesOnly(){
  //   _showFavoritesOnly=true;
  //   notifyListeners();
  // }
  // void showOnly(){
  //   _showFavoritesOnly=false;
  //   notifyListeners();
  // }
  void addProduct (Product product){
    final newProduct=Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct);
    notifyListeners();
  }
  void updateProduct(String id,Product newProduct){
    final prodIndex=_items.indexWhere((prod) => prod.id==id);
    if(prodIndex>=0){
      _items[prodIndex]=newProduct;
      notifyListeners();
    }else{
      print('...');
    }
  }
  void deleteProduct(String id){
    _items.removeWhere((prod)=>prod.id==id);
    notifyListeners();
  }

}