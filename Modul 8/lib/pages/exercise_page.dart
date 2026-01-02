import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();

  @override
  void dispose() {
    _stepsController.dispose();
    _moodController.dispose();
    super.dispose();
  }

  void _showStepsDialog(BuildContext context, HealthModel model) {
    _stepsController.text = model.steps.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Langkah Hari Ini'),
        content: TextField(
          controller: _stepsController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Jumlah Langkah'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final steps = int.tryParse(_stepsController.text) ?? model.steps;
              model.updateSteps(steps);
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showMoodDialog(BuildContext context, HealthModel model) {
    _moodController.text = model.mood.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Mood Anda'),
        content: TextField(
          controller: _moodController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Mood (1-10)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final mood = double.tryParse(_moodController.text) ?? model.mood;
              if (mood >= 1 && mood <= 10) {
                model.updateMood(mood);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Icon _getMoodIcon(double mood) {
    int rounded = mood.round();
    if (rounded <= 2) {
      return const Icon(Icons.sentiment_very_dissatisfied,
          size: 32, color: Colors.red);
    } else if (rounded <= 4) {
      return const Icon(Icons.sentiment_dissatisfied,
          size: 32, color: Colors.orange);
    } else if (rounded <= 6) {
      return const Icon(Icons.sentiment_neutral,
          size: 32, color: Colors.yellow);
    } else if (rounded <= 8) {
      return const Icon(Icons.sentiment_satisfied,
          size: 32, color: Colors.lightGreen);
    } else {
      return const Icon(Icons.sentiment_very_satisfied,
          size: 32, color: Colors.green);
    }
  }

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
                colors: [Colors.green[400]!, Colors.teal[700]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.fitness_center, size: 48, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Olahraga & Aktivitas',
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.directions_walk,
                              size: 32, color: Colors.green[700]),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Langkah Hari Ini',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              Text('${model.steps} langkah',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showStepsDialog(context, model),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.mood,
                              size: 32, color: Colors.purple[700]),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Mood Anda',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  Text('${model.mood.round()}/10',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  _getMoodIcon(model.mood),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showMoodDialog(context, model),
                        ),
                      ],
                    ),
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