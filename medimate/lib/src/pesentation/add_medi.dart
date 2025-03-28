// add_medicine.dart
import 'package:flutter/material.dart';
import 'package:medimate/src/pesentation/homepage.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class AddMedicineScreen extends StatefulWidget {
  static const String routeName = "/AddMedicineScreen";

  final String extractedText;
  const AddMedicineScreen({super.key, required this.extractedText});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  Database? _database;
  TextEditingController nameController = TextEditingController();
  List<bool> selectedDays = List.generate(7, (index) => false);
  Map<int, List<TimeOfDay>> selectedTimes = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.extractedText; // Autofill medicine name
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      _database = await openDatabase(
        p.join(await getDatabasesPath(), 'medicine_database.db'),
        version: 4,
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE medicines(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, days TEXT, times TEXT)",
          );
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 4) {
            await db.execute("ALTER TABLE medicines ADD COLUMN times TEXT");
          }
        },
      );
    } catch (e) {
      print("Database initialization error: $e");
    }
  }

  Future<void> saveMedicine() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a medicine name")),
      );
      return;
    }

    if (!selectedDays.contains(true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one day")),
      );
      return;
    }

    setState(() => isLoading = true);

    String days = selectedDays
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.toString())
        .join(',');

    String times = selectedTimes.entries
        .map((entry) =>
            "${entry.key}:${entry.value.map((t) => "${t.hour}:${t.minute}").join('|')}")
        .join(',');

    try {
      if (_database == null) {
        await _initDatabase();
        if (_database == null) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Database error. Please restart the app.")),
          );
          return;
        }
      }

      await _database!.insert(
        'medicines',
        {'name': nameController.text, 'days': days, 'times': times},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      setState(() => isLoading = false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false, // This removes all previous routes
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data stored successfully")),
      );
    } catch (e) {
      print("Error saving medicine: $e");
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save medicine: $e")),
      );
    }
  }

  Future<void> _selectTime(int dayIndex) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (!selectedTimes.containsKey(dayIndex)) {
          selectedTimes[dayIndex] = [];
        }
        selectedTimes[dayIndex]!.add(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Medicine")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Medicine Name"),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              const Text("Select Days:"),
              Wrap(
                spacing: 8.0,
                children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  String day = entry.value;
                  return FilterChip(
                    label: Text(day),
                    selected: selectedDays[index],
                    onSelected: (bool selected) {
                      setState(() {
                        selectedDays[index] = selected;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text("Select Time(s) for Each Selected Day:"),
              Column(
                children: selectedDays
                    .asMap()
                    .entries
                    .where((entry) => entry.value)
                    .map((entry) {
                  int index = entry.key;
                  String day =
                      ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Times for $day:"),
                          ElevatedButton(
                            onPressed: () => _selectTime(index),
                            child: const Text("Add Time"),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: selectedTimes[index]?.map((time) {
                              return Chip(
                                label: Text(DateFormat('hh:mm a').format(
                                    DateTime(0, 1, 1, time.hour, time.minute))),
                                onDeleted: () {
                                  setState(() {
                                    selectedTimes[index]!.remove(time);
                                  });
                                },
                              );
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (isLoading) const CircularProgressIndicator(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveMedicine,
                child: const Text("Save Medicine"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () async {
      await _database?.close();
    });
    super.dispose();
  }
}
