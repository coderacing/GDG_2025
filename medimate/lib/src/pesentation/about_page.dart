import 'package:flutter/material.dart';
import 'package:medimate/src/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = "/about";

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/app_icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              _buildSectionTitle("About the App"),
              _buildParagraph(
                  "BeInspired offers verses from the Bible, quotes from saints, and Catholic wallpapers daily throughout the year. It aims to encourage and motivate laity, religious, and clergy along their Christian journey."),
              const Divider(),
              _buildSectionTitle("Developers"),
              _buildParagraph(
                  "The app is developed by EthicCoders, a Catholic startup company specializing in purpose-driven and Catholic spirituality apps. With over 38+ apps developed for various organizations, they devote their development time to bringing technology to the Church."),
              const Divider(),
              _buildListTile(
                icon: Icons.web,
                title: "Visit Our Website",
                subtitle: "https://ethiccoders.com",
                onTap: () => _launchURL("https://ethiccoders.com"),
              ),
              const Divider(),
              _buildListTile(
                icon: Icons.email,
                title: "Contact Us",
                subtitle: "support@ethiccoders.com",
                onTap: () => _launchURL("mailto:support@ethiccoders.com"),
              ),
              const Divider(),
              _buildListTile(
                icon: Icons.lock,
                title: "Privacy Policy",
                subtitle: "Read our privacy policy",
                onTap: () => _launchURL("https://ethiccoders.com/privacy"),
              ),
              const Divider(),
              _buildListTile(
                icon: Icons.info,
                title: "App Version",
                subtitle: "1.0.0",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
