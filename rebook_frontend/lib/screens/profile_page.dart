import 'package:flutter/material.dart';
import 'package:rebook_frontend/services/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final data = await ApiService.getProfile();
      setState(() {
        profile = data;
        loading = false;
      });
    } catch (e) {
      print("Error loading profile: $e");
      setState(() => loading = false);
    }
  }

  Future<void> acceptExchange() async {
    try {
      await ApiService.acceptExchange();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exchange accepted!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to accept exchange')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
          backgroundColor: Color(0xC1FFAAD2),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : profile == null
          ? const Center(child: Text("Failed to load profile"))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profile!['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(profile!['email']),
            const SizedBox(height: 16),
            const Text("My Books:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ...List.generate(profile!['books'].length, (index) {
              final book = profile!['books'][index];
              return ListTile(
                title: Text(book['title']),
                subtitle: Text(book['author']),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: acceptExchange,
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xC1FFAAD2),),
              child: const Text("Accept Exchange Request"),
            ),
          ],
        ),
      ),
    );
  }
}
