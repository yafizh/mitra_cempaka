import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_cempaka/main.dart';
import 'package:mitra_cempaka/pages/detail_history_page.dart';
import 'package:mitra_cempaka/services/api/mitra_cempaka_api.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> histories = [];
  bool loading = true;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  final dateRangeController = TextEditingController();

  _getHistory() async {
    var response = await MitraCempakaApi.getHistory();

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

  Future _selectDateRange() async {
    DateTimeRange? selectDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectDateRange == null) return;

    setState(() => dateRange = selectDateRange);
  }

  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    dateRangeController.text =
        "${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day} to ${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}";

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: true,
                onTap: () => _selectDateRange(),
                controller: dateRangeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Cari Riwayat Penjualan',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
                            onPressed: () => _selectDateRange(),
                            icon: Icon(Icons.date_range_outlined),
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
  }
}
