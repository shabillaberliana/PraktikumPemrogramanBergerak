import 'package:flutter/material.dart';
import 'database/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  List<Map<String, dynamic>> dataList = [];

  Future loadData() async {
    dataList = await DatabaseHelper.instance.getAll();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Database SQLite")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Masukkan data",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseHelper.instance.insert(controller.text);
              controller.clear();
              loadData();
            },
            child: const Text("Simpan"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, i) {
                final item = dataList[i];
                return ListTile(
                  title: Text(item['title']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await DatabaseHelper.instance.delete(item['id']);
                      loadData();
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}