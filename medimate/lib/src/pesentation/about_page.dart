import 'package:flutter/material.dart';
import 'package:medimate/src/widgets/app_drawer.dart';
import 'package:medimate/src/utils/const.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = "/about";

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appTitle)),
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
              _buildSectionTitle(AppConstants.aboutAppTitle),
              _buildParagraph(AppConstants.aboutAppDescription),
              const Divider(),
              _buildSectionTitle(AppConstants.developersTitle),
              _buildParagraph(AppConstants.developersDescription),
              const Divider(),
              _buildSectionTitle(AppConstants.visitLinkedInTitle),
              ...AppConstants.developerLinks.map(
                (developer) => _buildClickableLink(
                  title: developer["name"]!,
                  url: developer["url"]!,
                ),
              ),
              const Divider(),
              _buildClickableLink(
                title: AppConstants.contactUsTitle,
                url: AppConstants.contactUsEmail,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info,
                    color: Color.fromARGB(255, 229, 139, 253)),
                title: const Text(AppConstants.appVersionTitle,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text(AppConstants.appVersion),
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
