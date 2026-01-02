import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});
  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  late TextEditingController _heightCtrl;
  late TextEditingController _weightCtrl;

  @override
  void initState() {
    super.initState();
    final model = Provider.of<HealthModel>(context, listen: false);
    _heightCtrl = TextEditingController(text: model.height.toString());
    _weightCtrl = TextEditingController(text: model.weight.toString());
  }

  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HealthModel>(context);
    final bmi = model.calculateBMI();
    final status = model.getBMIStatus();
    final color = model.getBMIColor();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.pink[700]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.scale, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                const Text('Kalkulator BMI',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Periksa status berat badan Anda',
                    style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Input Data',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _heightCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Tinggi Badan (cm)',
                      prefixIcon: const Icon(Icons.height),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _weightCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Berat Badan (kg)',
                      prefixIcon: const Icon(Icons.monitor_weight),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    onPressed: () {
                      final height = double.tryParse(_heightCtrl.text) ?? 170;
                      final weight = double.tryParse(_weightCtrl.text) ?? 70;
                      model.updateBMI(height, weight);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data BMI disimpan')),
                      );
                    },
                    child: const Text('Simpan Data',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.3), color],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color, width: 2),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text('Hasil BMI Anda',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.2),
                    border: Border.all(color: color, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildBMIInfo('Berat Badan Ideal',
                    '${model.height > 0 ? ((18.5 * model.height * model.height / 10000).toStringAsFixed(1)) : '0.0'} - ${((24.9 * model.height * model.height / 10000).toStringAsFixed(1))} kg'),
                const SizedBox(height: 12),
                _buildBMIInfo('Status', _getStatusDescription(status)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildBMIGuidelines(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'Kurus':
        return 'Anda kekurangan berat badan';
      case 'Normal':
        return 'Berat badan Anda ideal';
      case 'Gemuk':
        return 'Anda kelebihan berat badan';
      case 'Obesitas':
        return 'Anda mengalami obesitas';
      default:
        return '';
    }
  }

  Widget _buildBMIInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBMIGuidelines() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kategori BMI',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildCategoryItem(Colors.blue, 'Kurus', 'BMI < 18.5'),
            _buildCategoryItem(Colors.green, 'Normal', '18.5 - 24.9'),
            _buildCategoryItem(Colors.orange, 'Gemuk', '25 - 29.9'),
            _buildCategoryItem(Colors.red, 'Obesitas', 'BMI ≥ 30'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Color color, String label, String range) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(range, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
