import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:http/http.dart' as http;
import 'package:medimate/src/pesentation/add_medi.dart';
import 'package:medimate/src/widgets/app_drawer.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  XFile? imageFile;
  bool isLoading = false;
  TextEditingController medicineController = TextEditingController();
  Map<String, String> medicineDetails = {};

  final List<String> medicineList = [
    "Paracetamol",
    "Ibuprofen",
    "Aspirin",
    "Amoxicillin",
    "Metformin",
    "Cetirizine",
    "Omeprazole",
    "Atorvastatin",
    "Losartan",
    "Hydrochlorothiazide",
    "Avil",
    "Neurobion",
    "Diclofenac",
    "Tramadol",
    "Diphenhydramine",
    "Sertraline",
    "Escitalopram",
    "Citalopram",
    "Amitriptyline",
    "Prednisone",
    "Levothyroxine",
    "Acetaminophen"

  ];

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
        isLoading = true;
        medicineController.text = "Extracting text...";
        medicineDetails = {};
      });
      await extractTextFromImage(pickedFile.path);
    }
  }

  Future<void> extractTextFromImage(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      await textRecognizer.close();

      String rawText = recognizedText.text.trim();
      List<String> foundMedicines = findMedicinesInText(rawText);

      setState(() {
        medicineController.text = foundMedicines.join(", ");
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        medicineController.text = "Error recognizing text: $e";
        isLoading = false;
      });
    }
  }

  List<String> findMedicinesInText(String text) {
    List<String> foundMedicines = [];

    for (String medicine in medicineList) {
      if (text.toLowerCase().contains(medicine.toLowerCase())) {
        foundMedicines.add(medicine);
      }
    }

    if (foundMedicines.isEmpty) {
      final bestMatch = extractOne(query: text, choices: medicineList);
      if ((bestMatch.score ?? 0) > 70) {
        foundMedicines.add(bestMatch.choice);
      }
    }

    return foundMedicines.isNotEmpty ? foundMedicines : ["No medicines found"];
  }

  Future<void> fetchMedicineInfo() async {
    String userInput = medicineController.text.trim();
    if (userInput.isEmpty) return;

    List<String> medicines = userInput.split(", ");
    setState(() {
      medicineDetails.clear();
    });

    for (String medicine in medicines) {
      final url =
          "https://wsearch.nlm.nih.gov/ws/query?db=healthTopics&term=$medicine&retmax=1";
      print("Fetching: $url");

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          print("Response status code: ${response.statusCode}");
          print("Response body: ${response.body}");

          final document = xml.XmlDocument.parse(response.body);
          final transformer = Xml2Json();
          transformer.parse(document.toXmlString());

          var jsonData = jsonDecode(transformer.toParker());
          print("Parsed JSON data: $jsonData");

          var topics = jsonData['nlmSearchResult']?['list']?['document'];

          String details = "No details found.";

          if (topics != null) {
            if (topics is List && topics.isNotEmpty) {
              var firstTopic = topics.first;
              if (firstTopic is Map && firstTopic.containsKey('content')) {
                details = extractFullContent(firstTopic['content']);
              }
            } else if (topics is Map) {
              if (topics.containsKey('content')) {
                details = extractFullContent(topics['content']);
              }
            }
          }
          print("Extracted details: $details");

          if (mounted) {
            setState(() {
              medicineDetails[medicine] = details;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              medicineDetails[medicine] = "Failed to fetch information.";
            });
          }
        }
      } catch (e) {
        print("Error fetching data: $e");
        if (mounted) {
          setState(() {
            medicineDetails[medicine] = "Error fetching data: ${e.toString()}";
          });
        }
      }
    }
  }

  String extractFullContent(dynamic content) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Prescription")),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageFile != null
                  ? Image.file(File(imageFile!.path), width: 200, height: 200)
                  : Text("No image selected"),
              if (isLoading) CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: medicineController,
                  decoration: InputDecoration(
                    labelText: "Detected Medicines",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: fetchMedicineInfo,
                child: Text("Fetch Medicine Info"),
              ),
              ...medicineDetails.entries.map((entry) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key,
                          style: TextStyle(color: Colors.blue, fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text(entry.value, style: TextStyle(fontSize: 14)),
                      ),
                      if (entry.value != "No details found." &&
                          !entry.value.startsWith("Failed to fetch") &&
                          !entry.value.startsWith("Error fetching"))
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddMedicineScreen(
                                  extractedText: entry.key,
                                ),
                              ),
                            );
                          },
                          child: Text("Save"),
                        ),
                    ],
                  )),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.camera),
                icon: Icon(Icons.camera),
                label: Text("Take Photo"),
              ),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery),
                icon: Icon(Icons.image),
                label: Text("Upload from Gallery"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
