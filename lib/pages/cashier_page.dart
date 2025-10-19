import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/models/drug.dart';
import 'package:mitra_cempaka/pages/cart_page.dart';
import 'package:mitra_cempaka/services/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  List<Drug> drugs = [];

  final ScrollController _scrollController = ScrollController();

  int _page = 1;

  int _totalPage = 3;

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      drugs.add(Drug("Obat $i", Random().nextInt(100) + 10000));
    }

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (_page < _totalPage) {
          _page += 1;
          await Future.delayed(Duration(seconds: 3));
          final List<Drug> temp = [];
          for (int i = drugs.length + 1; i <= (20 * _page); i++) {
            temp.add(Drug("Obat $i", Random().nextInt(100) + 10000));
          }
          setState(() {
            drugs.addAll(temp);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            title: Text(
              "Kasir",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                color: theme.colorScheme.onPrimary,
                icon: cart.totalItem == 0
                    ? Icon(Icons.shopping_cart_outlined)
                    : Badge.count(
                        count: cart.totalItem,
                        child: Icon(Icons.shopping_cart_outlined),
                      ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[50],
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Cari Item',
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
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: (drugs.length + (_page == _totalPage ? 0 : 1)),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == drugs.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Card.filled(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Colors.white,
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
                            color: theme.colorScheme.primary,
                            onPressed: () {
                              if (cart.drugs.contains(drugs[index])) {
                                cart.remove(drugs[index]);
                              } else {
                                int discount = 0;
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                          'Add to chart',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.end,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            label: Text("Discount"),
                                            hintText: '0',
                                          ),
                                          autofocus: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          onChanged: (value) {
                                            discount = value.isEmpty
                                                ? 0
                                                : int.parse(value);
                                          },
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                              context,
                                              'Cancel',
                                            ),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              cart.add(drugs[index], discount);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Add'),
                                          ),
                                        ],
                                      ),
                                );
                              }
                            },
                            icon: Icon(
                              cart.drugs.contains(drugs[index])
                                  ? Icons.remove_shopping_cart_sharp
                                  : Icons.add_shopping_cart_sharp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
