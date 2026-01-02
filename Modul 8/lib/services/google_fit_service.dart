import 'package:health/health.dart';

class GoogleFitService {
  final HealthFactory _health = HealthFactory();

  Future<bool> requestPermissions() async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.HEART_RATE,
    ];
    try {
      final granted = await _health.requestAuthorization(types);
      return granted;
    } catch (e) {
      return false;
    }
  }

  Future<int> getStepsToday() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    try {
      final data = await _health.getHealthDataFromTypes(
        midnight,
        now,
        [HealthDataType.STEPS],
      );

      int total = 0;

      for (final d in data) {
        try {
          final steps = d.value as double?;
          if (steps != null) {
            total += steps.toInt();
          }
        } catch (_) {}
      }

      return total;
    } catch (e) {
      return 0;
    }
  }
}
