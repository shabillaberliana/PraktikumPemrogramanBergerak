import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Modul 4',
      initialRoute: '/',
      routes:{
        '/':(context)=>const HomePage(),
        '/pantai':(context)=>const MenuPage(menuTitle:'Pantai',icon:Icons.beach_access),
        '/gunung':(context)=>const MenuPage(menuTitle:'Gunung',icon:Icons.terrain),
        '/budaya':(context)=>const MenuPage(menuTitle:'Budaya',icon:Icons.museum),
        '/kuliner':(context)=>const MenuPage(menuTitle:'Kuliner',icon:Icons.restaurant),
      },
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Beranda'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        padding: const EdgeInsets.all(20.0),
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/pantai');
            },
            icon: const Icon(Icons.beach_access),
            label: const Text('Pantai'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/gunung');
            },
            icon: const Icon(Icons.terrain),
            label: const Text('Gunung'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/budaya');
            },
            icon: const Icon(Icons.museum),
            label: const Text('Budaya'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/kuliner');
            },
            icon: const Icon(Icons.restaurant),
            label: const Text('Kuliner'),
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final String menuTitle;
  final IconData icon;

  const MenuPage({super.key, required this.menuTitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menuTitle),
      ),
      body:Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(icon),
          label:const Text('Kembali')
        ),
      ),
    );
  }
}