import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class CustomDialogs {
  static void showApprouverDialog(BuildContext context) {
    final TextEditingController motifController = TextEditingController();
    //XFile? selectedImage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildIcon(Icons.check, Colors.green),
                      const SizedBox(height: 16),
                      _buildTitle(
                        "Justifiez votre approbation (si vous le souhaitez)",
                          //"Pourriez-vous indiquer le\nmotif de votre approbation ?",
                          Colors.black),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: motifController,
                        hintText: "(facultatif)",
                        color: Colors.black,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      // _buildImagePickerButton(
                      //   context,
                      //   setState,
                      //   () async {
                      //     final ImagePicker picker = ImagePicker();
                      //     final XFile? image = await picker.pickImage(
                      //         source: ImageSource.gallery);
                      //     if (image != null) {
                      //       setState(() => selectedImage = image);
                      //     }
                      //   },
                      //   selectedImage,
                      // ),
                      // const SizedBox(height: 10),
                      _buildActionButtons(
                        context,
                        confirmColor: Colors.green,
                        onConfirm: () {
                          // Logique de validation
                          // Get.to(SuccessPage(
                          //     title: "Opération réussie!",
                          //     message:
                          //         "La dépense a été approuvée avec succès."));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void showRejeterDialog(BuildContext context) {
    final TextEditingController motifController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIcon(Icons.error_outlined, Colors.red),
                const SizedBox(height: 16),
                _buildTitle(
                  "Pourquoi souhaitez-vous\nannuler cette dépense ?",
                  Colors.black,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: motifController,
                  hintText: "Motif (obligatoire)",
                  color: Colors.black,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                _buildActionButtons(
                  context,
                  confirmColor: Colors.redAccent,
                  onConfirm: () {
                    // Logique de rejet
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widgets communs
  static Widget _buildIcon(IconData icon, Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(icon, color: color)),
    );
  }

  static Widget _buildTitle(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Color color,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: color),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.0),
        ),
      ),
    );
  }

  // static Widget _buildImagePickerButton(
  //   BuildContext context,
  //   StateSetter setState,
  //   VoidCallback onPressed,
  //   XFile? selectedImage,
  // ) {
  //   return Column(
  //     children: [
  //       ElevatedButton.icon(
  //         onPressed: onPressed,
  //         icon: const Icon(Icons.photo, color: Colors.white),
  //         label: const Text(
  //           "Joindre une image",
  //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
  //         ),
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.yellow.withValues(alpha: 0.5),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           minimumSize: Size(MediaQuery.sizeOf(context).width, 40),
  //         ),
  //       ),
  //       if (selectedImage != null) ...[
  //         const SizedBox(height: 10),
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: Image.file(
  //             File(selectedImage.path),
  //             height: 100,
  //           ),
  //         ),
  //       ],
  //     ],
  //   );
  // }

  static Widget _buildActionButtons(
    BuildContext context, {
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Confirmer",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(color: Colors.grey),
              backgroundColor: Colors.white,
            ),
            child: Text(
              "Abandonner",
              style: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
