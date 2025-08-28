import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:mitra_cempaka/models/drug.dart';

class CartModel extends ChangeNotifier {
  final List<Drug> _drugs = [];

  UnmodifiableListView<Drug> get drugs => UnmodifiableListView(_drugs);

  int get totalDrug => _drugs.length;
  int get totalDrugPrice => _drugs.fold(0, (sum, drug) => sum + drug.price);

  void add(Drug drug) {
    _drugs.add(drug);
    notifyListeners();
  }

  void remove(Drug drug) {
    _drugs.remove(drug);
    notifyListeners();
  }

  void removeAll() {
    _drugs.clear();
    notifyListeners();
  }
}
