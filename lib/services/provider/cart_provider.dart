import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:mitra_cempaka/models/cart.dart';
import 'package:mitra_cempaka/models/drug.dart';

class CartProvider extends ChangeNotifier {
  final List<Cart> _carts = [];

  UnmodifiableListView<Cart> get carts => UnmodifiableListView(_carts);
  UnmodifiableListView<Drug> get drugs =>
      UnmodifiableListView(_carts.map((item) => item.drug));

  int get totalItem => _carts.length;
  int get totalItemPrice => _carts.fold(
    0,
    (sum, item) =>
        sum +
        (item.quantity * item.drug.price) -
        (item.quantity * item.discount),
  );

  void add(Drug drug, int discount) {
    _carts.add(Cart(drug: drug, discount: discount));
    notifyListeners();
  }

  void remove(Drug drug) {
    _carts.removeWhere((cart) => cart.drug == drug);
    notifyListeners();
  }

  void removeAll() {
    _carts.clear();
    notifyListeners();
  }

  void addQuantity(int index) {
    _carts[index].setQuantity(_carts[index].quantity + 1);
    notifyListeners();
  }

  void setQuantity(int index, int quantity) {
    _carts[index].setQuantity(quantity);
    notifyListeners();
  }

  void minQuantity(int index) {
    final int quantity = _carts[index].quantity - 1;
    (quantity < 1)
        ? remove(_carts[index].drug)
        : _carts[index].setQuantity(quantity);

    notifyListeners();
  }
}
