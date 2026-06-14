import 'package:flutter/material.dart';

void main() {
  runApp(const LaundryApp());
}

class LaundryApp extends StatelessWidget {
  const LaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget machineCard(
    String name,
    String status,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.local_laundry_service,
              color: color,
              size: 40,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(status),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Book"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laundry Booking"),
      ),
      body: ListView(
        children: [
          machineCard(
            "WM1",
            "Running - 20 min left",
            Colors.red,
          ),
          machineCard(
            "WM2",
            "Free",
            Colors.green,
          ),
          machineCard(
            "WM3",
            "Reserved",
            Colors.orange,
          ),
        ],
      ),
    );
  }
}