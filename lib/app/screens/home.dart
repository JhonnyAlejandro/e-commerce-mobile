import 'dart:io';

import 'package:e_commerce_mobile/app/api/connection.dart';
import 'package:e_commerce_mobile/app/screens/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<void> downloadPDF(String route, String fileName) async {
  final response = await http.get(Uri.parse(url + route));

  if(response.statusCode == 200) {
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    
    await OpenFile.open(filePath);
  } else {
    throw Exception('Error al descargar PDF - Código de estado: ${response.statusCode}');
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45)
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 7,
                  spreadRadius: 5,
                  color: Colors.grey.withOpacity(0.7)
                )
              ],
              color: Colors.blue,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'Erika Vanessa Cuaran Inagan',
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Column(
            children: [
              Button(
                icon: Icons.shopping_cart,
                background: Colors.blue,
                text: 'Ventas',
                action: () async {
                  await downloadPDF('/sales', 'ventas.pdf');
                }
              ),
              const SizedBox(height: 25),
              Button(
                icon: Icons.request_quote,
                background: Colors.blue,
                text: 'Detalles de ventas',
                action: () async {
                  await downloadPDF('/sales-details', 'detalles-ventas.pdf');
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}