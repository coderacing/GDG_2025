import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medimate/src/pesentation/add_medi.dart';
import 'dart:async';

import 'package:medimate/src/widgets/app_drawer.dart';
import 'package:medimate/src/widgets/camera.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentTime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        currentTime = DateFormat('hh:mm a').format(DateTime.now());
      });
    });
  }

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/capsule.png'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getGreeting()}, Joanna",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Current Time: $currentTime",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications,
                      color: Colors.black54, size: 28),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: medicineList.length,
                  itemBuilder: (context, index) {
                    return MedicineCard(medicine: medicineList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: "Add Medicine",
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        color: medicine.color,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(medicine.image),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.time,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      medicine.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(medicine.description,
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Take"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Medicine {
  final String time, title, description, image;
  final Color color;

  Medicine({
    required this.time,
    required this.title,
    required this.description,
    required this.color,
    required this.image,
  });
}

List<Medicine> medicineList = [
  Medicine(
    time: "10:25 AM",
    title: "Next medicine in 45 mins",
    description: "Take your BP medicine Diuretics tablets with water",
    color: Colors.purple.shade100,
    image: 'assets/images/capsule.png',
  ),
  Medicine(
    time: "11:45 AM",
    title: "Bactrium Tablets",
    description: "Take your urine infection tablets Bactrium with water",
    color: Colors.pink.shade100,
    image: 'assets/images/capsule.png',
  ),
  Medicine(
    time: "02:00 PM",
    title: "Ibuprofen Tablets",
    description: "Take your back pain tablets Ibuprofen with milk",
    color: Colors.blue.shade100,
    image: 'assets/images/capsule.png',
  ),
  Medicine(
    time: "10:25 AM",
    title: "Next medicine in 45 mins",
    description: "Take your BP medicine Diuretics tablets with water",
    color: Colors.purple.shade100,
    image: 'assets/images/capsule.png',
  ),
  Medicine(
    time: "11:45 AM",
    title: "Bactrium Tablets",
    description: "Take your urine infection tablets Bactrium with water",
    color: Colors.pink.shade100,
    image: 'assets/images/capsule.png',
  ),
];
