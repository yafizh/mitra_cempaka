import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/pages/checkout_page.dart';
import 'package:mitra_cempaka/services/provider/cart_provider.dart';
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
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return cart.totalItem == 0
              ? Center(child: Text("Cart is empty"))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cart.carts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final drug = cart.carts[index].drug;
                            final controllerQuantity = TextEditingController(
                              text: cart.carts[index].quantity.toString(),
                            );

                            return Dismissible(
                              key: Key(drug.name),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                cart.remove(drug);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${drug.name} removed'),
                                  ),
                                );
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
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
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
                                        onPressed: () =>
                                            cart.minQuantity(index),
                                        icon: Icon(Icons.remove),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          controller: controllerQuantity,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              cart.setQuantity(
                                                index,
                                                int.parse(value),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {
                                          cart.addQuantity(index);
                                        },
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
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 16,
                        bottom: 24,
                      ),
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CheckoutPage(),
                            ),
                          );
                        },
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
                );
        },
      ),
    );
  }
}
