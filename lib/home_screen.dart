import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              child: ListTile(
                leading: const Icon(Icons.local_laundry_service),
                title: const Text("Laundry Booking"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/laundry',
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.kitchen),
                title: const Text("Kitchen Booking"),
                subtitle: const Text("Coming Soon"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text("Study Room"),
                subtitle: const Text("Coming Soon"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}