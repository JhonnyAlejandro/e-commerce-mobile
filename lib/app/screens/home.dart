import 'dart:io';

import 'package:e_commerce_mobile/app/api/connection.dart';
import 'package:e_commerce_mobile/app/screens/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
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
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
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
                  'Jhonny Alejandro Castaño Burbano',
                  style: TextStyle(
                    fontSize: 25,
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
                icon: Icons.description,
                background: Colors.blue,
                text: 'Informes',
                action: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                        child: Column(
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
                              action: () {}
                            ),
                            const SizedBox(height: 25),
                            Button(
                              icon: Icons.local_shipping,
                              background: Colors.blue,
                              text: 'Detalles de envíos',
                              action: () {}
                            ),
                            const Spacer(),
                            Button(
                              icon: Icons.cancel,
                              background: Colors.red,
                              text: 'Cancelar',
                              action: () {
                                Navigator.of(context).pop();
                              }
                            ),
                          ],
                        )
                      );
                    }
                  );
                }
              ),
              const SizedBox(height: 25),
              Button(
                icon: Icons.logout,
                background: Colors.red,
                text: 'Cerrar sesión',
                action: () {}
              ),
            ],
          ),
        ],
      ),
    );
  }
}