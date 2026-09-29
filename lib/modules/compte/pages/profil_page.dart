import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profil_controller.dart';

class ProfilPage extends GetView<ProfilController> {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser le contrôleur si nécessaire (déjà géré par ProfilPage)
    final TextEditingController nameController =
        TextEditingController(text: controller.name.value);
    final TextEditingController roleController =
        TextEditingController(text: controller.role.value);
    final TextEditingController phoneNumberController =
        TextEditingController(text: controller.phoneNumber.value);
    final TextEditingController emailController =
        TextEditingController(text: controller.email.value);
    final TextEditingController departmentController =
        TextEditingController(text: controller.department.value);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Modifier le profil",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 16),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: controller.profileImage.value,
                        child: controller.profileImage.value == null
                            ? Icon(Icons.person,
                                size: 60, color: AppColors.primary)
                            : null,
                      ),
                    ),
                    Container(
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
              ),

              const SizedBox(height: 8),
              const Text(
                "Nom",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildInputField(
                controller: nameController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12),
              const Text(
                "Rôle",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildInputField(
                controller: roleController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12),
              const Text(
                "Numéro professionnel",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildInputField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              const Text(
                "Email professionnel",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildInputField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              const Text(
                "Département",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildInputField(
                controller: departmentController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      roleController.text.isNotEmpty &&
                      phoneNumberController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      departmentController.text.isNotEmpty) {
                    controller.updateName(nameController.text);
                    controller.updateRole(roleController.text);
                    controller.updatePhoneNumber(phoneNumberController.text);
                    controller.updateEmail(emailController.text);
                    controller.updateDepartment(departmentController.text);
                    Navigator.pop(context);
                  } else {
                    Get.snackbar(
                        "Erreur", "Tous les champs doivent être remplis");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "MODIFIER",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

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
                Get.back();
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
}
