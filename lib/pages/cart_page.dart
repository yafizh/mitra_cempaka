import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return cart.totalDrug == 0
              ? Center(child: Text("Cart is empty"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cart.drugs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final drug = cart.drugs[index];
                            return Dismissible(
                              key: Key(drug.name),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                cart.remove(drug);
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 16.0),
                                color: Colors.red,
                                child: Text(
                                  "Drag to left to remove...",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                  ),
                                  title: Text(cart.drugs[index].name),
                                  subtitle: Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(cart.drugs[index].price),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 8.0,
                                    children: [
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {},
                                        icon: Icon(Icons.remove),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {},
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 24.0),
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            minimumSize: Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Checkout"),
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
