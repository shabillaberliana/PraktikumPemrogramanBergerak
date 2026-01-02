import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});
  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  final _calCtrl = TextEditingController();

  @override
  void dispose() {
    _calCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HealthModel>(context);
    _calCtrl.text = model.calories.toStringAsFixed(0);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[400]!, Colors.deepOrange[700]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.restaurant, size: 48, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Makan & Nutrisi',
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
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Kalori Hari Ini',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _calCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.local_fire_department),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'kcal',
                            filled: true,
                            fillColor: Colors.orange[50],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                        ),
                        onPressed: () {
                          final val =
                              double.tryParse(_calCtrl.text) ?? model.calories;
                          model.updateCalories(val);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Kalori disimpan')));
                        },
                        child: const Text('Simpan',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Air Minum',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    min: 0,
                    max: 12,
                    divisions: 12,
                    value: model.waterGlasses,
                    label: '${model.waterGlasses.round()} gelas',
                    activeColor: Colors.blue[600],
                    onChanged: (v) {
                      model.updateWater(v);
                      setState(() {});
                    },
                  ),
                  Text(
                    '${model.waterGlasses.round()} gelas',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
