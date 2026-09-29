import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProfilController extends GetxController {
  // Données du profil
  var name = "Victoire HOUNKPATIN".obs;
  var role = "Responsable des ventes".obs;
  var phoneNumber = "+229 01 40 45 67 89".obs;
  var email = "sena.estelle@sommimas.fr".obs;
  var department = "Comptabilité".obs;

  // Image de profil (initialement null, puis remplacée par une image sélectionnée)
  var profileImage = Rx<ImageProvider?>(null);

  // Méthodes pour modifier les informations
  void updateName(String newName) {
    name.value = newName;
  }

  void updateRole(String newRole) {
    role.value = newRole;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updateDepartment(String newDepartment) {
    department.value = newDepartment;
  }

  // Méthode pour sélectionner une image
  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage.value = FileImage(File(image.path));
    }
  }

  // Méthode pour prendre une photo avec la caméra
  Future<void> takeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      profileImage.value = FileImage(File(image.path));
    }
  }

  // Méthode pour supprimer la photo de profil
  void removeProfileImage() {
    profileImage.value = null;
  }
}