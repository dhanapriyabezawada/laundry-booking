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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laundry Booking'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.local_laundry_service),
            title: Text('WM1'),
            subtitle: Text('Running - 20 min left'),
          ),
          ListTile(
            leading: Icon(Icons.local_laundry_service),
            title: Text('WM2'),
            subtitle: Text('Free'),
          ),
          ListTile(
            leading: Icon(Icons.local_laundry_service),
            title: Text('WM3'),
            subtitle: Text('Reserved'),
          ),
        ],
      ),
    );
  }
}