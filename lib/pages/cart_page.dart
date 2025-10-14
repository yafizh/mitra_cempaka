import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/pages/checkout_page.dart';
import 'package:mitra_cempaka/services/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return cart.totalItem == 0
              ? Center(child: Text("Keranjang Kosong"))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: cart.carts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final drug = cart.carts[index].drug;
                            final controllerQuantity = TextEditingController(
                              text: cart.carts[index].quantity.toString(),
                            );
                            final discount = cart.carts[index].discount;

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
                              child: Card.filled(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(cart.drugs[index].name),
                                  subtitle: discount == 0
                                      ? Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID',
                                            symbol: 'Rp ',
                                            decimalDigits: 0,
                                          ).format(cart.drugs[index].price),
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                locale: 'id_ID',
                                                symbol: 'Rp ',
                                                decimalDigits: 0,
                                              ).format(
                                                cart.drugs[index].price -
                                                    discount,
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              NumberFormat.currency(
                                                locale: 'id_ID',
                                                symbol: 'Rp ',
                                                decimalDigits: 0,
                                              ).format(cart.drugs[index].price),
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
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
                          backgroundColor: theme.colorScheme.primary,
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
