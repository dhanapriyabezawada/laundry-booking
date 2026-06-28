import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final currentUserEmail =
      FirebaseAuth.instance.currentUser?.email;

  final userBookings = await FirebaseFirestore.instance
      .collection('bookings')
      .where('userEmail', isEqualTo: currentUserEmail)
      .where('status', isEqualTo: 'Booked')
      .get();

  if (userBookings.docs.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'You already have an active booking',
        ),
      ),
    );
    return;
  }

  final existingBookings = await FirebaseFirestore.instance
      .collection('bookings')
      .where('machineName', isEqualTo: machineName)
      .get();

  final queuePosition = existingBookings.docs.length + 1;

  await FirebaseFirestore.instance
      .collection('bookings')
      .add({
    'machineName': machineName,
    'userName': FirebaseAuth.instance.currentUser?.displayName,
    'userEmail': FirebaseAuth.instance.currentUser?.email,
    'queuePosition': queuePosition,
    'status': 'Booked',
    'bookingTime': Timestamp.now(),
  });

  final snapshot = await FirebaseFirestore.instance
      .collection('Machines')
      .where('Name', isEqualTo: machineName)
      .get();

  for (var doc in snapshot.docs) {
    await doc.reference.update({
      'status': 'Reserved',
    });
  }

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