import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where(
              'userEmail',
              isEqualTo: currentUser?.email,
            )
            .where(
              'status',
              isEqualTo: 'Booked',
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
    snapshot.data!.docs.isEmpty) {
  return const Center(
    child: Text("No Bookings"),
  );
}

final booking =
    snapshot.data!.docs.first;

final data =
    booking.data() as Map<String, dynamic>;
    return Padding(
  padding: const EdgeInsets.all(16),
  child: Card(
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Machine : ${data["machineName"]}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Status : ${data["status"]}",
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 10),

          Text(
            "Queue Position : ${data["queuePosition"]}",
            style: const TextStyle(fontSize: 18),

          ),
          const SizedBox(height: 25),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
   onPressed: () async {
  await booking.reference.update({
    'status': 'Cancelled',
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Booking Cancelled Successfully",
      ),
    ),
  );
},
    child: const Text(
      "Cancel Booking",
    ),
  ),
),

        ],
      ),
    ),
  ),
);
        },
      ),
    );
  }
}