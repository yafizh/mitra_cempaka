import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/models/drug.dart';
import 'package:mitra_cempaka/pages/detail_history_page.dart';
import 'package:mitra_cempaka/services/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
    final theme = Theme.of(context);

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            title: Text(
              "Riwayat Penjualan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.grey[50],
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Column(
              children: [
                Expanded(
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

                      return Card.filled(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          title: Text("15:30 - Saturday, 20 April 2025"),
                          subtitle: Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(drugs[index].price),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailHistoryPage(id: 1),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.lightBlueAccent,
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
