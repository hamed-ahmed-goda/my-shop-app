import 'dart:ffi';

import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
class EditProductScreen extends StatefulWidget {
  static const routeName='edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String ? urlImage;
  final _form=GlobalKey<FormState>();
  var _editProduct=Product(
      id: '',
      title: '',
      description: '',
      price:0,
      imageUrl: '',
  );
  var _initvalues={
    'title':'',
    'description':'',
    'price':'',
    'imageUrl':'',
  };
  var _isInit=true;

  void _saveForm(){
    final isValid=_form.currentState!.validate();
    if(!isValid){
      return;
    }
     _form.currentState!.save();
    if(_editProduct.id!=null){
      Provider.of<Products>(context,listen: false).updateProduct(_editProduct.id,_editProduct);
    }else{
      Provider.of<Products>(context,listen: false).addProduct(_editProduct);
    }

    Navigator.of(context).pop();
  }
  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId= ModalRoute.of(context)!.settings.arguments as String;
      if(productId!=null){
        _editProduct=Provider.of<Products>(context,listen: false).findById(productId);
        _initvalues={
          'title':_editProduct.title,
          'description':_editProduct.description,
          'price':_editProduct.price.toString(),
          'imageUrl':_editProduct.imageUrl,

        };

      }

    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('edit products'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initvalues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value){
                  _editProduct=Product(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                      title:'$value',
                      description: _editProduct.description,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl,
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return'Please Provide a value';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initvalues['price'],
                decoration: InputDecoration(labelText: 'price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                  onSaved: (value){
                    _editProduct=Product(
                      id: _editProduct.id,
                      isFavorite: _editProduct.isFavorite,
                    title:_editProduct.title,
                    description: _editProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editProduct.imageUrl,
                    );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return'please enter a price';
                  }
                  if(double.tryParse(value)==null){
                    return'please enter a valid number';
                  }
                  if(double.parse(value)<=0){
                    return 'please enter a number greater than zero';

                  }
                  return null;
                },
              ),
              TextFormField(
                  initialValue: _initvalues['description'],
                decoration: InputDecoration(labelText: 'Description', ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (value){
                  if(value!.isEmpty){
                    return 'please enter a description';
                  }
                  if(value.length<10){
                    return 'should be at least 10 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title:_editProduct.title ,
                    description: '$value',
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child:urlImage==null?Text('enter url'):FittedBox(child: Image.network(urlImage!),fit: BoxFit.cover,),
                  ),
                  Expanded(
                    child: TextFormField(
                        initialValue: _initvalues['imageUrl'],
                      decoration: InputDecoration(labelText:'Image URL' ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      validator: (value){
                        if(value!.isEmpty){
                          return'please enter an image URL ';
                        }
                        if(!value.startsWith('http')&&!value.startsWith('https')){
                          return 'please enter a valid URL';
                        }
                        if(!value.endsWith('.png')&&!value.endsWith('.jpg')&&!value.endsWith('.jpeg')){
                          return 'please enter a valid image URl';
                        }
                        return null;
                      },
                        onChanged: (uRl){

                          setState(() {
                            urlImage=uRl;
                            print(uRl);
                          });


                      },
                      onFieldSubmitted: (_){
                        _saveForm();
                      },
                        onSaved: (value) {
                          _editProduct = Product(
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                            title:_editProduct.title ,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            imageUrl:'$value' ,
                          );
                        }
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
