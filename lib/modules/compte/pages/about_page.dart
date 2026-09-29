import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text('À propos de l\'application'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo et nom de l'application
            Image.asset(
              'assets/images/logo_somimas.png',
              height: 100,
              width: MediaQuery.of(context).size.width,
              //fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Somimas - Gestion des Dépenses ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),

            // Section Description
            _buildAboutSection(
              icon: Icons.info_outline,
              title: 'Description',
              content: Text(
                'Cette application permet aux employés de Somimas de gérer, suivre et soumettre leurs dépenses professionnelles de manière efficace et transparente. Gagnez du temps dans la gestion des frais.',
                textAlign: TextAlign.justify,
              ),
            ),

            // Section Fonctionnalités
            _buildAboutSection(
              icon: Icons.assessment_outlined,
              title: 'Fonctionnalités clés',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _FeatureItem('Soumission des notes de frais'),
                  _FeatureItem('Suivi en temps réel des dépenses'),
                  _FeatureItem('Validation hiérarchique'),
                  _FeatureItem('Historique complet des transactions'),
                  _FeatureItem('Intégration avec la comptabilité'),
                ],
              ),
            ),

            // Section Version
            _buildAboutSection(
              icon: Icons.update,
              title: 'Version',
              content: const Text(
                'Version 1.0.0\n'
                'Dernière mise à jour: 15/06/2023',
                textAlign: TextAlign.center,
              ),
            ),

            // Section Contact
            _buildAboutSection(
              icon: Icons.contact_support_outlined,
              title: 'Contact & Support',
              content: Column(
                children: [
                  _buildContactItem(
                    Icons.email,
                    'support@somimas.com',
                    () => _launchEmail('support@somimas.com'),
                  ),
                  _buildContactItem(
                    Icons.phone,
                    '+225 XX XX XX XX',
                    () => _launchPhone('+225XXXXXXXX'),
                  ),
                  _buildContactItem(
                    Icons.language,
                    'www.somimas.com',
                    () => _launchUrl('https://www.somimas.com'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Text(
              '© ${DateTime.now().year} SOMIMAS. Tous droits réservés.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: content is Text
                ? content
                : DefaultTextStyle(
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    child: content,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(text),
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -4),
      onTap: onTap,
    );
  }

  static Future<void> _launchEmail(String email) async {
    final Uri uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.circle, size: 8, color: AppColors.primary),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
