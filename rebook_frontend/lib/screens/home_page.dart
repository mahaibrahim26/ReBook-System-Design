import 'package:flutter/material.dart';
import 'package:rebook_frontend/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> books = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    try {
      final allBooks = await ApiService.getBooks();
      setState(() {
        books = allBooks.where((book) => book['owner']['name'] != 'User1').toList();
        loading = false;
      });
    } catch (e) {
      print("Error loading books: $e");
      setState(() => loading = false);
    }
  }

  Future<void> sendRequest(String name) async {
    try {
      await ApiService.sendExchangeRequest('User1');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exchange request sent!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send request')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Available Books"),
        backgroundColor: Color(0xC1FFAAD2),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : books.isEmpty
          ? const Center(child: Text("No books available for exchange"))
          : ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 3,
            child: ListTile(
              title: Text(book['title']),
              subtitle: Text("by ${book['author']} (Owner: ${book['owner']['name']})"),
              trailing: ElevatedButton(
                onPressed: () => sendRequest('User1'),
                child: const Text("Request"),
              ),
            ),
          );
        },
      ),
    );
  }
}
