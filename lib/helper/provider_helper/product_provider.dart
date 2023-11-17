import 'package:flutter/material.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../../utils/images.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product("Chicken\nBiriyani", biriyani,0,130,1),
    Product("Fish", fish, 0, 0,2),
  ];

  List<Product> _selectedProducts = [];
  List<Product> _bagProducts = [];

  List<Product> get products => _products;
  List<Product> get selectedProducts => _selectedProducts;
  List<Product> get bagProducts => _bagProducts;

  int get productCount => _selectedProducts.length;

  List<Product> get selectedProductsFiltered {
    return _selectedProducts.where((product) => product.count > 0).toList();
  }

  void addSelectedProductsToBag(List<Product> selectedProducts) {
    for (final product in bagProducts) {
      final int index = _bagProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _bagProducts[index].count += product.count;
      } else {
        _bagProducts.add(product);
      }
    }
    notifyListeners();
  }

  void clearSelection() {
    for (final product in _selectedProducts) {
      product.count = 0;
    }
    _selectedProducts.clear();
    notifyListeners();
  }

  double calculateTotalPrice(List<Product> selectedProducts) {
    double totalPrice = 0.0;
    for (final product in selectedProducts) {
      totalPrice += product.amount * product.count;
    }
    return totalPrice;
  }

  double calculateBagTotalPrice(List<Product> selectedProducts) {
    double totalPrice = 0.0;
    for (final product in selectedProducts) {
      totalPrice += product.amount * product.count;
    }
    return totalPrice;
  }


  void toggleSelection(Product product) {
    if (_selectedProducts.contains(product)) {
    } else {
      _selectedProducts.add(product);
    }
    notifyListeners();
  }
  void incrementCount(Product product) {
    product.count++;
    notifyListeners();
  }

  void decrementCount(Product product) {
    if (product.count > 0) {
      product.count--;
      notifyListeners();
    }
  }

  void removeSelectedProduct(int index) {
    _selectedProducts.removeAt(index);
    notifyListeners();
  }


}

