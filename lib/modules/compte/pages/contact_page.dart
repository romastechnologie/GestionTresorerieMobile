import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('CONTACT SOMIMAS',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête avec logo et info basique
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.sizeOf(context).width,
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset('assets/images/logo_somimas.png', height: 80),
                  const SizedBox(height: 15),
                  const Text('SOMIMAS Sarl \n(SOCIETE MISSI MAWU)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text('Quincaillerie professionnelle',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Section de contact principale
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactSection(),
                  const SizedBox(height: 4),
                  _buildOpeningHours(),
                  const SizedBox(height: 4),
                  _buildSurcusalesSection(),
                ],
              ),
            ),

            // Section d'appel à action
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.sizeOf(context).width,
              color: Colors.white,
              child: Column(
                children: [
                  // const Text("C'est votre entreprise ?",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold)),
                  // const SizedBox(height: 10),
                  // const Text(
                  //     "Des prospects vous recherchent, aidez-nous à vous mettre en relation :",
                  //     textAlign: TextAlign.center),
                  // const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[800],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text('NOUS CONTACTER',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('COORDONNÉES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            const SizedBox(height: 10),
            _buildContactItem(Icons.location_on,
                'Von de la Garderie des Enfants\nSainte Rita\nCotonou - Benin'),
            _buildContactItem(Icons.language, 'www.somimas.com', isLink: true),
            _buildContactItem(Icons.phone, '(+229) 01 96 44 91 98',
                isPhone: true),
            _buildContactItem(Icons.phone, '(+229) 01 96 11 09 17',
                isPhone: true),
          ],
        ),
      ),
    );
  }

  Widget _buildOpeningHours() {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('HORAIRES D\'OUVERTURE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 5),
                Text('Ouvert', style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 10),
            _buildScheduleRow('Lundi', '08H00 — 13H00, 15H00 — 19H00'),
            _buildScheduleRow('Mardi', '08H00 — 13H00, 15H00 — 19H00'),
            _buildScheduleRow('Mercredi', '08H00 — 13H00, 15H00 — 19H00'),
            _buildScheduleRow('Jeudi', '08H00 — 13H00, 15H00 — 19H00'),
            _buildScheduleRow('Vendredi', '08H00 — 13H00, 15H00 — 19H00'),
            _buildScheduleRow('Samedi', 'Fermé', isClosed: true),
            _buildScheduleRow('Dimanche', 'Fermé', isClosed: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSurcusalesSection() {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SURCCURSALES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            const SizedBox(height: 10),
            _buildBranchCard(
                'Non loin du Carrefour Togoudo,\n en allant vers Womey à Gauche',
                'Cotonou - Benin'),
            const SizedBox(height: 10),
            _buildBranchCard('Quartier Kpocan', 'Bohicon - Benin'),
          ],
        ),
      ),
    );
  }
}

Widget _buildContactItem(IconData icon, String text,
    {bool isLink = false, bool isPhone = false}) {
  return GestureDetector(
    onTap: () {
      if (isLink) launchUrl(Uri.parse('http://$text'));
      if (isPhone) launchUrl(Uri.parse('tel:$text'));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange[800]),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    color: isLink || isPhone ? Colors.blue : Colors.black,
                    decoration:
                        isLink || isPhone ? TextDecoration.underline : null)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildScheduleRow(String day, String hours, {bool isClosed = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
            width: 80,
            child: Text(day,
                style:
                    TextStyle(color: isClosed ? Colors.grey : Colors.black))),
        Text(hours,
            style: TextStyle(color: isClosed ? Colors.grey : Colors.black)),
      ],
    ),
  );
}

Widget _buildBranchCard(String address, String city) {
  return SizedBox(
    //padding: const EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          size: 40,
          color: Colors.deepOrange,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address,
            ),
            Text(city, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text('VOIR SUR LA CARTE',
            //         style: TextStyle(color: Colors.orange)),
            //   ),
            // ),
          ],
        ),
      ],
    ),
  );
}
