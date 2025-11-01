import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/main.dart';
import 'package:mitra_cempaka/models/drug.dart';
import 'package:mitra_cempaka/pages/detail_history_page.dart';
import 'package:mitra_cempaka/services/api/mitra_cempaka_api.dart';
import 'package:mitra_cempaka/services/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> histories = [];
  bool loading = true;

  _getHistory() async {
    var response = await MitraCempakaApi.getHistory();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      setState(() {
        histories = (responseBody['data'] as List).map((history) {
          final parsed = DateFormat(
            'yyyy-MM-dd HH:mm',
          ).parse(history['created_at'], false).toLocal();
          final createdAt = DateFormat(
            'HH:mm - dd MMMM yyyy',
            'id_ID',
          ).format(parsed);
          return {'createdAt': createdAt, 'total': history['total']};
        }).toList();
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getHistory();
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
                  child: loading
                      ? Padding(
                          padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : ListView.builder(
                          itemCount: histories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card.filled(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                title: Text(histories[index]['createdAt']),
                                subtitle: Text(
                                  NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(histories[index]['total']),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    AppNavigator.key.currentState?.push(
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
