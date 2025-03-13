import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentTime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 30), (timer) {
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
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/capsule.png'),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getGreeting()}, Joanna",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Current Time: $currentTime",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.notifications, color: Colors.black54, size: 28),
                ],
              ),
              SizedBox(height: 20),
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
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        color: medicine.color,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(medicine.image),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.time,
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      medicine.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(medicine.description,
                        style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Take"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
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
