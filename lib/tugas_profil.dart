import 'package:flutter/material.dart';

class TugasProfilPage extends StatefulWidget {
  const TugasProfilPage({super.key});

  @override
  State<TugasProfilPage> createState() => _TugasProfilPageState();
}

class _TugasProfilPageState extends State<TugasProfilPage> {
  String name = "Raja Zhafif";
  String email = "raja@example.com";
  String bio = "Mahasiswa Teknologi Mobile";

  void _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(name: name, bio: bio),
      ),
    );
    if (result != null && result is Map<String, String>) {
      setState(() {
        name = result['name'] ?? name;
        bio = result['bio'] ?? bio;
      });
    }
  }

  void _onPhotoTap() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Foto Profil Ditekan!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _onPhotoTap,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  child: const Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ProfileInfoItem(label: "Nama", value: name),
              ProfileInfoItem(label: "Email", value: email),
              ProfileInfoItem(label: "Bio", value: bio),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _editProfile,
                child: const Text("Edit Profil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoItem({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String bio;

  const EditProfileScreen({required this.name, required this.bio, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    print('EditProfileScreen initState');
    _nameController = TextEditingController(text: widget.name);
    _bioController = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    print('EditProfileScreen dispose');
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'bio': _bioController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: "Bio"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              child: const Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
