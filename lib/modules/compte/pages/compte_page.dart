import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profil_controller.dart';

class ComptePage extends GetView<ProfilController> {
  const ComptePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser le contrôleur
    Get.put(ProfilController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Compte",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.edit, color: Colors.white),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => EditProfilPage()),
        //       );
        //     },
        //   ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      color: AppColors.primary,
                    ),
                    Container(
                      height: 90,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  //width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image de profil avec icône de modification
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const SizedBox(width: 16),
                          Obx(
                            () => CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: controller.profileImage.value,
                              child: controller.profileImage.value == null
                                  ? Icon(Icons.person,
                                      size: 50, color: AppColors.primary)
                                  : null,
                            ),
                          ),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 18),
                              onPressed: () {
                                _showImagePickerBottomSheet(context);
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          // Nom et rôle
                          Obx(
                            () => Text(
                              controller.name.value,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                //color: Colors.white,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.role.value,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Partie basse (Informations)
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1 / 12,
          // ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildSettingOption(
                      context,
                      title: 'Mon profil',
                      icon: Icons.person_outline_outlined,
                      onTap: () {
                        Get.toNamed('/profil');
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildSettingOption(
                      context,
                      title: 'Sécurité ',
                      icon: Icons.security_update_outlined,
                      onTap: () {
                        Get.toNamed('/security');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Contact',
                      icon: Icons.contact_support_outlined,
                      onTap: () {
                        Get.toNamed('/contact');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSettingOption(
                      context,
                      title: 'À propos',
                      icon: Icons.help_outline,
                      onTap: () {
                        Get.toNamed('/about');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildLogoutOption(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildInfoRow({
  //   required String label,
  //   required String value,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               label,
  //               style: const TextStyle(
  //                 fontFamily: 'Inter',
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w500,
  //                 color: Color(0xFFB0BEC5),
  //               ),
  //             ),
  //             Text(
  //               value,
  //               style: const TextStyle(
  //                 fontFamily: 'Inter',
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w400,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choisir depuis la galerie"),
              onTap: () async {
                await controller.pickProfileImage();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Prendre une photo"),
              onTap: () async {
                await controller.takeProfilePicture();
                //Navigator.pop(context);
              },
            ),
            if (controller.profileImage.value != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Supprimer la photo",
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  controller.removeProfileImage();
                  Navigator.pop(context);
                },
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Icon(icon, color: Colors.grey[600]),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing:
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutOption(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.logout, color: Colors.red[400]),
        title: Text(
          'Se déconnecter ',
          style: TextStyle(
              color: Colors.red[400],
              fontWeight: FontWeight.w400,
              fontSize: 17),
        ),
        trailing:
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red[400]),
        onTap: () => _confirmLogout(context),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Get.offNamed('/login');
              // Implémentez la déconnexion
              //print('User logged out');
            },
            child:
                const Text('Déconnexion', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
