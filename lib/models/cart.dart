import 'package:mitra_cempaka/models/drug.dart';

class Cart {
  Drug drug;
  int quantity;
  int discount;

  Cart({required this.drug, this.quantity = 1, this.discount = 0});

  void setQuantity(int quantity) => this.quantity = quantity;
}
