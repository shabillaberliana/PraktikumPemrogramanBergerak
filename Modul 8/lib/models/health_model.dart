import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthModel extends ChangeNotifier {
  String name = "User";
  String username = "";
  String password = "";
  bool loggedIn = false;
  String email = "";
  String phone = "";
  String birthDate = "";
  String gender = "";
  String photoUrl = "";

  double calories = 2000;
  double waterGlasses = 4;
  int steps = 3000;
  double sleepHours = 7;
  double mood = 7;

  double height = 170;
  double weight = 70;

  List<double> weekCalories = [2000, 1900, 2200, 2100, 1800, 2300, 2000];
  List<double> weekSleep = [7, 6.5, 8, 7.5, 6, 8, 7];

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? "User";
    username = prefs.getString('username') ?? "";
    password = prefs.getString('password') ?? "";
    loggedIn = prefs.getBool('loggedIn') ?? false;
    email = prefs.getString('email') ?? "";
    phone = prefs.getString('phone') ?? "";
    birthDate = prefs.getString('birthDate') ?? "";
    gender = prefs.getString('gender') ?? "";
    photoUrl = prefs.getString('photoUrl') ?? "";
    calories = prefs.getDouble('calories') ?? 2000;
    waterGlasses = prefs.getDouble('waterGlasses') ?? 4;
    steps = prefs.getInt('steps') ?? 3000;
    sleepHours = prefs.getDouble('sleepHours') ?? 7;
    mood = prefs.getDouble('mood') ?? 7;
    height = prefs.getDouble('height') ?? 170;
    weight = prefs.getDouble('weight') ?? 70;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setBool('loggedIn', loggedIn);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('birthDate', birthDate);
    await prefs.setString('gender', gender);
    await prefs.setString('photoUrl', photoUrl);
    await prefs.setDouble('calories', calories);
    await prefs.setDouble('waterGlasses', waterGlasses);
    await prefs.setInt('steps', steps);
    await prefs.setDouble('sleepHours', sleepHours);
    await prefs.setDouble('mood', mood);
    await prefs.setDouble('height', height);
    await prefs.setDouble('weight', weight);
  }

  void login(String uname, String pwd) {
    username = uname;
    password = pwd;
    loggedIn = true;
    _save();
    notifyListeners();
  }

  void signup(String uname, String pwd, String fullName) {
    username = uname;
    password = pwd;
    name = fullName;
    loggedIn = true;
    _save();
    notifyListeners();
  }

  void logout() {
    loggedIn = false;
    _save();
    notifyListeners();
  }

  void updateCalories(double v) {
    calories = v;
    _save();
    notifyListeners();
  }

  void updateWater(double v) {
    waterGlasses = v;
    _save();
    notifyListeners();
  }

  void updateSteps(int v) {
    steps = v;
    _save();
    notifyListeners();
  }

  void updateSleep(double v) {
    sleepHours = v;
    _save();
    notifyListeners();
  }

  void updateMood(double v) {
    mood = v;
    _save();
    notifyListeners();
  }

  void addDailySnapshot() {
    weekCalories.removeAt(0);
    weekCalories.add(calories);
    weekSleep.removeAt(0);
    weekSleep.add(sleepHours);
    notifyListeners();
  }

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  String getBMIStatus() {
    final bmi = calculateBMI();
    if (bmi < 18.5) return "Kurus";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Gemuk";
    return "Obesitas";
  }

  Color getBMIColor() {
    final bmi = calculateBMI();
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  void updateProfile({
    String? fullName,
    String? em,
    String? ph,
    String? birth,
    String? gen,
    String? photo,
  }) {
    if (fullName != null) name = fullName;
    if (em != null) email = em;
    if (ph != null) phone = ph;
    if (birth != null) birthDate = birth;
    if (gen != null) gender = gen;
    if (photo != null) photoUrl = photo;
    _save();
    notifyListeners();
  }

  void updateBMI(double h, double w) {
    height = h;
    weight = w;
    _save();
    notifyListeners();
  }
}
