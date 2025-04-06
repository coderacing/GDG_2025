import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NearestPharmacyPage extends StatefulWidget {
  const NearestPharmacyPage({super.key});
  static const String routeName = "/NearestPharmacyPage";

  @override
  State<NearestPharmacyPage> createState() => _NearestPharmacyPageState();
}

class _NearestPharmacyPageState extends State<NearestPharmacyPage> {
  List pharmacies = [];
  bool isLoading = true;
  late Position _userPosition;

  @override
  void initState() {
    super.initState();
    _fetchNearbyPharmacies();
  }

  Future<void> _fetchNearbyPharmacies() async {
    try {
      // Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Please enable them from settings.');
      }

      // Get current location
      _userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      final url =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_userPosition.latitude},${_userPosition.longitude}&radius=3000&type=pharmacy&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        setState(() {
          pharmacies = data['results'];
          isLoading = false;
        });
      } else {
        throw Exception(data['error_message'] ?? 'Failed to load places');
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _launchMap(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch map';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearest Pharmacy')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pharmacies.isEmpty
              ? const Center(child: Text("No pharmacies found nearby."))
              : ListView.builder(
                  itemCount: pharmacies.length,
                  itemBuilder: (context, index) {
                    final place = pharmacies[index];
                    final name = place['name'];
                    final address = place['vicinity'];
                    final lat = place['geometry']['location']['lat'];
                    final lng = place['geometry']['location']['lng'];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text(address),
                        leading: const Icon(Icons.local_pharmacy,
                            color: Colors.green),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => _launchMap(lat, lng),
                      ),
                    );
                  },
                ),
    );
  }
}
