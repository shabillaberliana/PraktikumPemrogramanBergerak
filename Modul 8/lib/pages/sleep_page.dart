import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});
  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HealthModel>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[400]!, Colors.purple[700]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.bedtime, size: 48, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Manajemen Tidur',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jam Tidur Malam Terakhir',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 36, color: Colors.indigo[700]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${model.sleepHours.toStringAsFixed(1)} jam',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    min: 0,
                    max: 12,
                    divisions: 24,
                    value: model.sleepHours,
                    label: '${model.sleepHours.toStringAsFixed(1)} jam',
                    activeColor: Colors.indigo[700],
                    onChanged: (v) {
                      model.updateSleep(v);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('Tips Tidur Lebih Baik',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildTip('Matikan layar 1 jam sebelum tidur'),
                  _buildTip('Jaga kamar gelap dan sejuk'),
                  _buildTip('Hindari kafein malam hari'),
                  _buildTip('Tidur dan bangun pada jam yang sama'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.teal, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(tip, style: const TextStyle(fontSize: 14)),
          )
        ],
      ),
    );
  }
}
