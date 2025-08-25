import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/models/cart_model.dart';
import 'package:mitra_cempaka/models/drug.dart';
import 'package:provider/provider.dart';

class CashierPage extends StatelessWidget {
  CashierPage({super.key});

  List<Drug> drugs = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 20; i++) {
      drugs.add(Drug("Obat $i", Random().nextInt(100) + 10000));
    }

    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Cashier",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    // Navigator.of(
                    //   context,
                    // ).push(MaterialPageRoute(builder: (context) => const CartPage()));
                  },
                  icon: Badge.count(
                    count: cart.totalDrug,
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Search Item',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      suffixIcon: SizedBox(
                        width: 100,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const VerticalDivider(
                                color: Colors.black,
                                indent: 10,
                                endIndent: 10,
                                thickness: 0.4,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: drugs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(drugs[index].name),
                            subtitle: Text(
                              NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(drugs[index].price),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                cart.items.contains(drugs[index])
                                    ? cart.remove(drugs[index])
                                    : cart.add(drugs[index]);
                              },
                              icon: Icon(
                                cart.items.contains(drugs[index])
                                    ? Icons.remove_shopping_cart_sharp
                                    : Icons.add_shopping_cart_sharp,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
