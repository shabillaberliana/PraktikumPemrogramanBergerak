import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';
import 'dashboard_page.dart';
import 'meal_page.dart';
import 'exercise_page.dart';
import 'sleep_page.dart';
import 'profile_page.dart';
import 'bmi_page.dart';
import 'login_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _idx = 0;
  final pages = const [
    DashboardPage(),
    MealPage(),
    ExercisePage(),
    SleepPage(),
    BMIPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HealthModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, ${model.name}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan[400]!, Colors.teal[700]!],
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                model.addDailySnapshot();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Snapshot disimpan')));
              },
              icon: const Icon(Icons.save)),
          IconButton(
              onPressed: () {
                model.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal[700],
        unselectedItemColor: Colors.grey[400],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Makan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Olahraga'),
          BottomNavigationBarItem(icon: Icon(Icons.hotel), label: 'Tidur'),
          BottomNavigationBarItem(icon: Icon(Icons.scale), label: 'BMI'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
