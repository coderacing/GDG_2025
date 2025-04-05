import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medimate/src/pesentation/details_page.dart';
import 'package:medimate/src/services/alarm_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:medimate/src/widgets/app_drawer.dart';
import 'package:medimate/src/widgets/camera.dart';
import 'package:alarm/alarm.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentTime = DateFormat('hh:mm a').format(DateTime.now());
  Database? _database;
  List<Medicine> medicineList = [];

  @override
  void initState() {
    super.initState();
    _initDatabase().then((_) => fetchMedicines());
    Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        currentTime = DateFormat('hh:mm a').format(DateTime.now());
      });
    });
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'medicine_database.db'),
      version: 4,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE medicines(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, days TEXT, times TEXT)",
        );
      },
    );
  }

  Future<void> fetchMedicines() async {
    if (_database == null) return;

    final List<Map<String, dynamic>> maps = await _database!.query('medicines');

    setState(() {
      medicineList = maps.map((map) {
        String timesString = map['times'] ?? "";

        String displayTimes = "";
        if (timesString.isNotEmpty) {
          displayTimes = timesString.split(',').map((dayTimes) {
            final parts = dayTimes.split(':');
            if (parts.length == 2) {
              final dayIndex = int.parse(parts[0]);
              final timeList = parts[1].split('|');

              final day =
                  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][dayIndex];
              final times = timeList.join(', ');
              return "$day: $times";
            }
            return "";
          }).join('; ');
        }

        return Medicine(
          id: map['id'],
          title: map['name'],
          time: displayTimes,
          description: "Take your medicine on time",
          color: Colors.pink.shade100,
          image: 'assets/images/capsule.png',
          alarmId: DateTime.now().millisecondsSinceEpoch % 100000,
        );
      }).toList();
    });

    await AlarmService.scheduleMedicineAlarms(maps);
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
                child: medicineList.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              image:
                                  AssetImage("assets/images/no_medicine.png"),
                              width: 150,
                              height: 150,
                            ),
                            SizedBox(height: 10),
                            Text("No medicines added"),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: medicineList.length,
                        itemBuilder: (context, index) {
                          return MedicineCard(medicine: medicineList[index]);
                        },
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraScreen()),
          );
          await fetchMedicines();
        },
        child: const Icon(Icons.add),
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
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(medicineId: medicine.id),
            ),
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                        medicine.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        medicine.description,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Alarm.stop(medicine.alarmId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Alarm stopped")),
                    );
                  },
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
      ),
    );
  }
}

class Medicine {
  final int id;
  final int alarmId;
  final String time, title, description, image;
  final Color color;

  Medicine({
    required this.id,
    required this.alarmId,
    required this.time,
    required this.title,
    required this.description,
    required this.color,
    required this.image,
  });
}
