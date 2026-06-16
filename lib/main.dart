
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'booking_screen.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
import 'dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser != null
    ? const DashboardScreen()
    : const LoginScreen(),
    routes: {
  '/dashboard': (context) => const DashboardScreen(),
  '/home': (context) => const HomeScreen(),
  '/laundry': (context) => const LaundryScreen(),
},
    );
  }
}

// Replace the rest of your existing file below this line unchanged.

class LaundryScreen extends StatefulWidget {
  const LaundryScreen({super.key});

  @override
  State<LaundryScreen> createState() => _LaundryScreenState();
}

class _LaundryScreenState extends State<LaundryScreen> {
  List<Map<String, dynamic>> machines = [
    {
      "name": "WM1",
      "status": "Running",
      "remainingTime": 20,
      "color": Colors.red,
      "queue": 0,
      
    },
    {
      "name": "WM2",
      "status": "Free",
      "remainingTime": 0,
      "color": Colors.green,
      "queue": 0,
      
    },
    {
      "name": "WM3",
      "status": "Reserved",
      "remainingTime": 20,
      "color": Colors.orange,
      "queue": 0,
      
    },
  ];
Timer? countdownTimer;

@override
void initState() {
  super.initState();
  loadMachines();
}
Future<void> loadMachines() async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Machines')
        .get();

    print("Machines found: ${snapshot.docs.length}");

   setState(() {
  machines = snapshot.docs.map((doc) {
    return {
      "name": doc["Name"],
      "status": doc["status"],
      "remainingTime": 0,
      "color": Colors.green,
      "queue": 0,
    };
  }).toList();
});
  } catch (e) {
    print("Firestore Error: $e");
  }
}

@override
void dispose() {
  countdownTimer?.cancel();
  super.dispose();
}
void startCountdown() {
  countdownTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      setState(() {
        for (var machine in machines) {
          if (machine["remainingTime"] > 0) {
  machine["remainingTime"]--;
}

if (machine["remainingTime"] == 0 &&
    machine["queue"] == 0) {
  machine["status"] = "Free";
  machine["color"] = Colors.green;
}
        }
      });
    },
  );
}
  Widget machineCard(
  BuildContext context,
  String name,
  String status,
  int remainingTime,
  Color color,
  int queue,
)
  {
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
                  Text("Status: $status"),
                  Text("Remaining Time: $remainingTime min"),
                  Text("Queue: $queue"),
                  Text(
  "Estimated Wait: ${remainingTime + (queue * 20)} min",
),
              
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(
                      machineName: name,
                      status: status,
                    ),
                  ),
                );
if (result == "booked") {
  int queuePosition = 0;
               
                  setState(() {
                    for (var machine in machines) {
                      if (machine["name"] == name) {
                        if (machine["status"] == "Free") {
                          machine["status"] = "Reserved";
                          machine["color"] = Colors.orange;
                        } else {
                          queuePosition = machine["queue"] + 1;
                          machine["queue"]++;
                        }
                      }
                    }
                  });
                  if (queuePosition > 0) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Booking Successful\nQueue Position: #$queuePosition",
      ),
    ),
  );
}
                }
              },
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
          for (var machine in machines)
            machineCard(
              context,
              machine["name"],
              machine["status"],
              machine["remainingTime"],
              machine["color"],
              machine["queue"],
          
            ),
        ],
      ),
    );
  }
}

