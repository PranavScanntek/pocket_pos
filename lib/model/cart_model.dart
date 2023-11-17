import 'package:pocket_pos/model/product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  int? count;
  double? amount;

  CartItem({ required this.product, required this.quantity,this.count,this.amount, });

}