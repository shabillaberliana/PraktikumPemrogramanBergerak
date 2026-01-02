import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CalorieChart extends StatelessWidget {
  final List<double> data;
  const CalorieChart({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(show: true, bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (val, meta) {
        final idx = val.toInt();
        const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
        if (idx < 0 || idx >= days.length) return const SizedBox.shrink();
        return Text(days[idx], style: const TextStyle(fontSize: 10));
      }))),
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value / 1000)).toList(),
          isCurved: true,
          dotData: FlDotData(show: true),
        )
      ],
    ));
  }
}

class SleepChart extends StatelessWidget {
  final List<double> data;
  const SleepChart({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(show: true, bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (val, meta) {
        final idx = val.toInt();
        const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
        if (idx < 0 || idx >= days.length) return const SizedBox.shrink();
        return Text(days[idx], style: const TextStyle(fontSize: 10));
      }))),
      barGroups: data.asMap().entries.map((e) => BarChartGroupData(x: e.key, barRods: [BarChartRodData(toY: e.value)])).toList(),
    ));
  }
}
