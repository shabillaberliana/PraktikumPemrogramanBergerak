import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
build(context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 180, 242),
        leading: const Icon(Icons.home),
        title: const Text('Layout Praktikum')),

      body:Container(
        margin: const EdgeInsets.all(10.0), //KODE UNTUK MENGATUR MARGIN
        child:Column(children:<Widget>[
          Row(children:const<Widget> [
            Icon(Icons.archive),
            Text('Media Terbaru',
            style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Borobudur_Temple.jpg/320px-Borobudur_Temple.jpg',
                    ),
                    const Text('Candi Borobudur'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}