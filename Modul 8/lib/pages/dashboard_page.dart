import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';
import '../widgets/charts.dart';
import '../widgets/summary_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HealthModel>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.local_fire_department,
                  title: 'Kalori',
                  subtitle: '${model.calories.round()} kcal',
                  color: Colors.orange[600],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.bubble_chart,
                  title: 'Air Minum',
                  subtitle: '${model.waterGlasses.round()} gelas',
                  color: Colors.blue[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.directions_walk,
                  title: 'Langkah',
                  subtitle: '${model.steps} langkah',
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.bedtime,
                  title: 'Tidur',
                  subtitle: '${model.sleepHours} jam',
                  color: Colors.purple[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Kalori Mingguan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Perkembangan 7 hari terakhir'),
                  ),
                  SizedBox(
                    height: 200,
                    child: CalorieChart(data: model.weekCalories),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Tidur Mingguan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Trend tidur'),
                  ),
                  SizedBox(
                    height: 200,
                    child: SleepChart(data: model.weekSleep),
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
