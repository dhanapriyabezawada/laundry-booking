
import 'package:flutter/material.dart';
import 'booking_screen.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

                if (result == true) {
                  setState(() {
                    for (var machine in machines) {
                      if (machine["name"] == name) {
                        if (machine["status"] == "Free") {
                          machine["status"] = "Reserved";
                          machine["color"] = Colors.orange;
                        } else {
                          machine["queue"]++;
                        }
                      }
                    }
                  });
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

