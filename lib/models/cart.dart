import 'package:mitra_cempaka/models/drug.dart';

class Cart {
  Drug drug;
  int quantity;

  Cart({required this.drug, this.quantity = 1});

  void setQuantity(int quantity) => this.quantity = quantity;
}
