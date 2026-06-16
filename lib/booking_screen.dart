import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BookingScreen extends StatelessWidget {
  final String machineName;
  final String status;

  const BookingScreen({
    super.key,
    required this.machineName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Machine"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              machineName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Status: $status",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
  await FirebaseFirestore.instance
      .collection('bookings')
      .add({
    'machineName': machineName,
    'status': 'Booked',
    'bookingTime': Timestamp.now(),
  });

  Navigator.pop(context, "booked");
},
              child: const Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}