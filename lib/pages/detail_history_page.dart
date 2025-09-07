import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/models/drug.dart';

class DetailHistoryPage extends StatelessWidget {
  final int id;
  List<Drug> drugs = [];

  DetailHistoryPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 20; i++) {
      drugs.add(Drug("Obat $i", Random().nextInt(100) + 10000));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: drugs.length,
              itemBuilder: (BuildContext context, int index) {
                final drug = drugs[index];

                return ListTile(
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  shape: Border(bottom: BorderSide(color: Colors.grey)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(drug.name),
                      Text("x1", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(drug.price),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(drug.price * 1),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
            child: FilledButton(
              onPressed: () {
                //
              },
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Print"),
            ),
          ),
        ],
      ),
    );
  }
}
