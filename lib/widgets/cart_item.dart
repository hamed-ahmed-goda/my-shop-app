import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  CartItem(this.id,this.productId, this.quantity, this.price, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:ValueKey(id),

      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(
            context: context,
            builder: (context)=>AlertDialog(
              title: Text('Are you sure?'),
              content: Text(
                'Do you want to remove the item from cart?'
              ),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.of(context).pop(false);
                },
                  child: Text('No'),
                ),
                FlatButton(onPressed: (){
                  Navigator.of(context).pop(true);
                },
                  child: Text('Yes'),
                ),
              ],
            ),
        );
      },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total:\$${(price * quantity).toStringAsFixed(3)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
