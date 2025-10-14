import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({super.key});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  late final Future<Uint8List> _bytesFuture;

  Future<Uint8List> _fetch() async {
    final res = await http.get(
      Uri.parse(
        "https://www.pepitas.net/sites/default/files/newsletter/files/pepitas_primera_mitad_2015.pdf",
      ),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to load PDF: ${res.statusCode}');
    }
    return res.bodyBytes;
  }

  @override
  void initState() {
    super.initState();
    _bytesFuture = _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "10:30 - Saturday, 20 April 2025",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: FutureBuilder<Uint8List>(
        future: _bytesFuture,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final bytes = snap.data!;

          // PdfPreview shows thumbnails, toolbar (print/share), page nav, etc.
          return PdfPreview(
            // we're previewing an existing PDF; page format is irrelevant
            canChangePageFormat: false,
            allowPrinting: true,
            allowSharing: true,
            build: (format) async => bytes,
          );
        },
      ),
    );
  }
}
