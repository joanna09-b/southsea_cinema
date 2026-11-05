import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:southsea_cinema/models/user_settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _receiveNewsletters = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String phoneNumber = _phoneController.text.trim();

    final UserSettings settings = UserSettings(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      receiveNewsletters: _receiveNewsletters,
    );

    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.name}';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Customer Profile',
             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: cinemaFontWhite)),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                labelStyle: TextStyle(color: cinemaFontWhite),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email address',
                labelStyle: TextStyle(color: cinemaFontWhite),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                labelStyle: TextStyle(color: cinemaFontWhite),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Text('Receive Newsletters via email', style: TextStyle(color: cinemaFontWhite))),
                Switch(
                  value: _receiveNewsletters,
                  onChanged: (bool value) {
                    setState(() {
                      _receiveNewsletters = value;
                    });
                  },
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: double.infinity,
                  child: CinemaButton(
                    label: 'Save Settings',
                    onPressed: _saveSettings,
                  ),
                ),
                if (_confirmationMessage.isNotEmpty)...[
                  
                  const SizedBox(height: 12),
                  Text(
                    _confirmationMessage,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ],
            ),        
                 
          ],
        ),
      ),
    );
  }
}
