import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_model.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _birthCtrl;
  late TextEditingController _genderCtrl;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final model = Provider.of<HealthModel>(context, listen: false);
    _nameCtrl = TextEditingController(text: model.name);
    _emailCtrl = TextEditingController(text: model.email);
    _phoneCtrl = TextEditingController(text: model.phone);
    _birthCtrl = TextEditingController(text: model.birthDate);
    _genderCtrl = TextEditingController(text: model.gender);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _birthCtrl.dispose();
    _genderCtrl.dispose();
    super.dispose();
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
                colors: [Colors.cyan[400]!, Colors.teal[700]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.teal, width: 3),
                  ),
                  child: model.photoUrl.isEmpty
                      ? Icon(Icons.person, size: 50, color: Colors.teal[700])
                      : ClipOval(
                          child: Image.network(
                            model.photoUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Text(model.name,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text('@${model.username}',
                    style:
                        const TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Informasi Profil',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      _isEditing
                          ? TextButton(
                              onPressed: () {
                                model.updateProfile(
                                  fullName: _nameCtrl.text,
                                  em: _emailCtrl.text,
                                  ph: _phoneCtrl.text,
                                  birth: _birthCtrl.text,
                                  gen: _genderCtrl.text,
                                );
                                setState(() => _isEditing = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Profil diperbarui')),
                                );
                              },
                              child: const Text('Simpan',
                                  style: TextStyle(color: Colors.teal)))
                          : IconButton(
                              onPressed: () =>
                                  setState(() => _isEditing = true),
                              icon: const Icon(Icons.edit, color: Colors.teal),
                            )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildProfileField('Nama', _nameCtrl),
                  _buildProfileField('Email', _emailCtrl),
                  _buildProfileField('Nomor HP', _phoneCtrl),
                  _buildProfileField('Tanggal Lahir (YYYY-MM-DD)', _birthCtrl),
                  _buildProfileField('Jenis Kelamin', _genderCtrl),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.account_circle_outlined),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Username'),
                          Text(model.username,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            onPressed: () {
              model.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            child: const Text('Logout',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: _isEditing ? Colors.grey[50] : Colors.grey[100],
        ),
      ),
    );
  }
}
