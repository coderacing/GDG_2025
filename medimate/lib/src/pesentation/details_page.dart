import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DetailsPage extends StatefulWidget {
  final int medicineId;

  const DetailsPage({super.key, required this.medicineId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String medicineName = "";
  String medicineTimes = "";
  String apiDetails = "Loading...";
  Database? _database;

  @override
  void initState() {
    super.initState();
    _loadMedicineDetails();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      p.join(await getDatabasesPath(), 'medicine_database.db'),
      version: 4,
    );
  }

  Future<void> _loadMedicineDetails() async {
    await _initDatabase();
    if (_database == null) return;

    final List<Map<String, dynamic>> maps = await _database!.query(
      'medicines',
      where: 'id = ?',
      whereArgs: [widget.medicineId],
    );

    if (maps.isNotEmpty) {
      final med = maps.first;
      medicineName = med['name'];
      medicineTimes = med['times'] ?? "No times stored";
      setState(() {});
      _fetchMedicineApiInfo(medicineName);
    }
  }

  Future<void> _fetchMedicineApiInfo(String medicine) async {
    final url =
        "https://wsearch.nlm.nih.gov/ws/query?db=healthTopics&term=$medicine&retmax=1";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final transformer = Xml2Json();
        transformer.parse(document.toXmlString());
        var jsonData = transformer.toParker();
        var mapData = jsonDecode(jsonData);

        var topics = mapData['nlmSearchResult']?['list']?['document'];
        String details = "No details found.";

        if (topics != null) {
          if (topics is List && topics.isNotEmpty) {
            var content = topics.first['content'];
            details = _extractFullContent(content);
          } else if (topics is Map && topics.containsKey('content')) {
            details = _extractFullContent(topics['content']);
          }
        }

        setState(() {
          apiDetails = details;
        });
      } else {
        setState(() {
          apiDetails = "Failed to fetch from API";
        });
      }
    } catch (e) {
      setState(() {
        apiDetails = "Error fetching details: $e";
      });
    }
  }

  String _extractFullContent(dynamic content) {
    String extracted = "";
    if (content is List) {
      for (var item in content) {
        if (item is Map && item.containsKey(r'$t')) {
          extracted += "${_removeTags(item[r'$t'])} \n";
        } else if (item is Map) {
          extracted += "${_removeTags(item.values.join(" "))} \n";
        } else {
          extracted += "${_removeTags(item.toString())} \n";
        }
      }
    } else if (content is Map) {
      if (content.containsKey(r'$t')) {
        extracted = _removeTags(content[r'$t']);
      } else {
        extracted = _removeTags(content.values.join("\n"));
      }
    } else {
      extracted = _removeTags(content.toString());
    }
    return extracted.trim();
  }

  String _removeTags(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  List<Widget> _formatTimeChips(String rawTimes) {
    List<Widget> chips = [];

    if (rawTimes.isEmpty) return [const Text("No times available")];

    // Example rawTimes: "1:10:56|15:30,3:9:00|22:15"
    final dayTimeEntries = rawTimes.split(',');

    for (var entry in dayTimeEntries) {
      final parts = entry.split(':');
      if (parts.length >= 2) {
        final times = parts.sublist(1).join(':'); // skip the day index
        final timeStrings = times.split('|');
        for (var t in timeStrings) {
          final timeParts = t.split(':');
          if (timeParts.length == 2) {
            int hour = int.tryParse(timeParts[0]) ?? 0;
            int minute = int.tryParse(timeParts[1]) ?? 0;
            final formatted =
                DateFormat('hh:mm a').format(DateTime(0, 1, 1, hour, minute));
            chips.add(
              GestureDetector(
                onTap: () => _confirmRemoveTime(entry, t),
                child: Chip(label: Text(formatted)),
              ),
            );
          }
        }
      }
    }

    return chips;
  }

  Future<void> _confirmRemoveTime(String dayEntry, String timeToRemove) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove Time?"),
        content: Text("Do you want to remove the time $timeToRemove?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Remove")),
        ],
      ),
    );

    if (!confirmed) return;

    // Parse and update
    List<String> entries = medicineTimes.split(',');
    List<String> updatedEntries = [];

    for (var entry in entries) {
      if (!entry.contains(':')) continue;
      List<String> parts = entry.split(':');
      int dayIndex = int.parse(parts[0]);
      String timesStr = entry.substring(entry.indexOf(':') + 1);
      List<String> timeList = timesStr.split('|');

      if (entry == dayEntry) {
        timeList.remove(timeToRemove);
        if (timeList.isNotEmpty) {
          updatedEntries.add("$dayIndex:${timeList.join('|')}");
        }
        // else skip, because all times removed for this day
      } else {
        updatedEntries.add(entry);
      }
    }

    String newTimes = updatedEntries.join(',');

    // Update DB
    await _database!.update(
      'medicines',
      {'times': newTimes},
      where: 'id = ?',
      whereArgs: [widget.medicineId],
    );

    setState(() {
      medicineTimes = newTimes;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Time removed successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: medicineName.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Medicine: $medicineName",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Time(s):", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        Wrap(
                          spacing: 8.0,
                          children: _formatTimeChips(medicineTimes),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    const Text("Details from API:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(apiDetails, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _database?.close();
    super.dispose();
  }
}
