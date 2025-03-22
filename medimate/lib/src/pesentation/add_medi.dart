import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AddMedicineScreen extends StatefulWidget {
  final String extractedText;
  const AddMedicineScreen({super.key, required this.extractedText});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  late Database database;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    nameController.text = widget.extractedText; // Pre-fill extracted text
  }

  // Initialize SQLite Database
  Future<void> _initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'medicine_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE medicines(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, details TEXT)",
        );
      },
      version: 1,
    );
  }

  // Save Medicine to SQLite
  Future<void> saveMedicine() async {
    if (nameController.text.isEmpty) return;

    setState(() => isLoading = true);

    await database.insert(
      'medicines',
      {'name': nameController.text, 'details': detailsController.text},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    setState(() => isLoading = false);
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text("Medicine saved successfully!")),
    );

    Navigator.pop(context as BuildContext); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Medicine")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Medicine Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: "Medicine Details"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            isLoading ? const CircularProgressIndicator() : const SizedBox.shrink(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveMedicine,
              child: const Text("Save Medicine"),
            ),
          ],
        ),
      ),
    );
  }
}
