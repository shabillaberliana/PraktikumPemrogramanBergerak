// lib/main.dart (LENGKAP)

import 'package:flutter/material.dart';
import 'list_item_widget.dart'; // import ini seharusnya sudah benar
import 'bottom_nav_widget.dart'; // import ini seharusnya sudah benar

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modul 6',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ListScreen(),
    );
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
        backgroundColor: Colors.indigo,
      ),
      
      // Body menggunakan ListView dan ListItemWidget
      body: ListView(
        children: const <Widget>[
          ListItemWidget(title: 'Item Pertama', subtitle: 'Baris pertama deskripsi.'),
          ListItemWidget(title: 'Item Kedua', subtitle: 'Baris kedua dengan data lebih panjang.'),
          ListItemWidget(title: 'Item Ketiga', subtitle: 'Ini adalah item ketiga dalam daftar.'),
          ListItemWidget(title: 'Item Keempat', subtitle: 'Baris keempat, melanjutkan daftar.'),
          ListItemWidget(title: 'Item Kelima', subtitle: 'Item terakhir dalam tampilan ini.'),
        ],
      ),
      
      // bottomNavigationBar menggunakan BottomNavWidget
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}