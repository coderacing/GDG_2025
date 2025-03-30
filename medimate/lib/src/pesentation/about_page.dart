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
                  'assets/images/app_logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              _buildSectionTitle("About the App"),
              _buildParagraph(
                  "MediMate helps you manage medications effortlessly with smart reminders and an intuitive interface. Stay on top of prescriptions, vitamins, and treatments for yourself or loved ones, and never miss a dose again!"),
              const Divider(),
              _buildSectionTitle("Developers"),
              _buildParagraph(
                  "The app is developed by CodeRacers, a team of four passionate developers, dedicated to creating innovative solutions for everyday problems. We believe in the power of technology to make a positive impact on people's lives, and we strive to create apps that are user-friendly, reliable, and accessible to everyone."),
              const Divider(),
              _buildSectionTitle("Visit Our LinkedIn Profiles"),
              _buildClickableLink(
                title: "Aswin Oomen Jacob",
                url: "https://www.linkedin.com/in/aswin-jacob-1ba26923b/",
              ),
              _buildClickableLink(
                title: "Angel Shibu",
                url: "https://www.linkedin.com/in/angel-shibu-a60251347",
              ),
              _buildClickableLink(
                title: "Christa Rachel Varghese",
                url: "https://www.linkedin.com/in/christa-varghese-957316282/",
              ),
              _buildClickableLink(
                title: "Ninz Milka Loji",
                url: "https://www.linkedin.com/in/ninz-milka-loji-7a6154264",
              ),
              const Divider(),
              _buildClickableLink(
                title: "Contact Us",
                url: "mailto:coderacers3@gmail.com",
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info,
                    color: Color.fromARGB(255, 229, 139, 253)),
                title: const Text("App Version",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("1.0.0"),
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

  Widget _buildClickableLink({required String title, required String url}) {
    return ListTile(
      leading:
          const Icon(Icons.link, color: Color.fromARGB(255, 229, 139, 253)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: InkWell(
        onTap: () => _launchURL(url),
        child: Text(
          url,
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}
