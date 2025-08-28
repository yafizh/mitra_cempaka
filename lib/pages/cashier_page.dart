import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/models/cart_model.dart';
import 'package:mitra_cempaka/models/drug.dart';
import 'package:provider/provider.dart';

class CashierPage extends StatefulWidget {
  CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  List<Drug> drugs = [];

  ScrollController _scrollController = new ScrollController();

  int _page = 1;

  int _totalPage = 3;

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      drugs.add(Drug("Obat $i", Random().nextInt(100) + 10000));
    }

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_page < _totalPage) {
          _page += 1;
          await Future.delayed(Duration(seconds: 3));
          final temp = [];
          for (int i = drugs.length + 1; i <= (20 * _page); i++) {
            temp.add(Drug("Obat $i", Random().nextInt(100) + 10000));
          }
          setState(() {
            drugs = [...drugs, ...temp];
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
                  icon: cart.totalDrug == 0
                      ? Icon(Icons.shopping_cart_outlined)
                      : Badge.count(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: (drugs.length + (_page == _totalPage ? 0 : 1)),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == drugs.length) {
                          return Padding(
                            padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

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
