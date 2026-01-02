import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';

class MoreHealthPage extends StatefulWidget {
  const MoreHealthPage({super.key});
  @override
  State<MoreHealthPage> createState() => _MoreHealthPageState();
}

class _MoreHealthPageState extends State<MoreHealthPage> {
  final _bpCtrl = TextEditingController(text: '120/80');
  @override
  void dispose() {
    _bpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HealthModel>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text('Kesehatan Lainnya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(elevation:6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Mood (1-10)'),
            Slider(min: 1, max: 10, divisions: 9, value: model.mood, label: '${model.mood.round()}', onChanged: (v) => model.updateMood(v)),
            const SizedBox(height: 12),
            const Divider(),
            const Text('Tanda Vital (mock)'),
            const SizedBox(height: 8),
            TextField(controller: _bpCtrl, decoration: const InputDecoration(prefixIcon: Icon(Icons.favorite), labelText: 'Tekanan Darah (mmHg)')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tanda vital disimpan (mock)'))); }, child: const Text('Simpan')),
          ]),
        )),
      ]),
    );
  }
}
