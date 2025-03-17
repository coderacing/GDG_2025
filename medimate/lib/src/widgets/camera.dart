import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:medimate/src/pesentation/add_medi.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  XFile? imageFile;
  bool isLoading = false;
  String extractedText = "";

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
        extractedText = "Extracting text...";
        isLoading = true;
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

      setState(() {
        extractedText = recognizedText.text.isNotEmpty
            ? recognizedText.text
            : "No text found";
        isLoading = false;
      });

      // Navigate to AddMedicineScreen with extracted text
      if (extractedText.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddMedicineScreen(extractedText: extractedText),
          ),
        );
      }
    } catch (e) {
      setState(() {
        extractedText = "Error recognizing text: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Prescription")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageFile != null
                ? Image.file(File(imageFile!.path), width: 200, height: 200)
                : Text("No image selected"),
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading && extractedText.isNotEmpty) Text(extractedText),
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
    );
  }
}
