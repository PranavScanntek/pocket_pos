// import 'package:flutter/cupertino.dart';
// import '../../model/cart_model.dart';
// import '../../model/product_model.dart';
//
// class CartProvider extends ChangeNotifier {
//   List<CartItem> _cartItems = [];
//
//   List<CartItem> get cartItems => _cartItems;
//
//   void addToCart(Product product) {
//     final existingCartItem = _cartItems.firstWhere(
//           (item) => item.product.id == product.id,
//       orElse: () => CartItem(product: product, quantity: 1),
//     );
//
//     if (existingCartItem == null) {
//       _cartItems.add(CartItem(product: product, quantity: 1));
//     } else {
//       existingCartItem.quantity++;
//     }
//     notifyListeners();
//   }
//
//   double get totalPrice {
//     return _cartItems.fold(0.0, (total, product) => product.count! * product.amount);
//   }
//
//   void incrementCount(Product product) {
//     product.count++;
//     notifyListeners();
//   }
//
//   void decrementCount(Product product) {
//     if (product.count > 0) {
//       product.count--;
//       notifyListeners();
//     }
//   }
//
//   void removeSelectedProduct(int index) {
//     _cartItems.removeAt(index);
//     notifyListeners();
//   }
//
// }