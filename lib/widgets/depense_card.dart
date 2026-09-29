// // import 'package:expense_manager/constants/colors.dart';
// // import 'package:expense_manager/pages/details_depense.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'dart:io';
// // import 'package:image_picker/image_picker.dart';

// // class DepenseCard extends StatelessWidget {
// //   final DateTime date;
// //   final String categorie;
// //   final String description;
// //   final int montant;
// //   final bool isRejected;

// //   const DepenseCard({
// //     super.key,
// //     required this.date,
// //     required this.categorie,
// //     required this.description,
// //     required this.montant,
// //     this.isRejected = false,
// //   });

// //   void showApprouverDialog(BuildContext context) {
// //     final TextEditingController motifController = TextEditingController();
// //     XFile? selectedImage;

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return StatefulBuilder(
// //           // pour gérer setState dans la boîte
// //           builder: (context, setState) {
// //             return Dialog(
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(16)),
// //               backgroundColor: Colors.blue.shade100,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       // Icône d'alerte
// //                       Container(
// //                         width: 48,
// //                         height: 48,
// //                         decoration: BoxDecoration(
// //                           border: Border.all(color: AppColors.yellow, width: 2),
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Center(
// //                           child: Icon(Icons.check, color: AppColors.yellow),
// //                         ),
// //                       ),
// //                       SizedBox(height: 16),
// //                       Text(
// //                         "Pourriez-vous indiquer le\nmotif de votre approbation ?",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           color: AppColors.yellow,
// //                           fontWeight: FontWeight.w500,
// //                           fontSize: 18,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 20),
// //                       TextField(
// //                         controller: motifController,
// //                         maxLines: 3,
// //                         decoration: InputDecoration(
// //                           hintText: "Motif (facultatif)",
// //                           hintStyle: TextStyle(
// //                             fontSize: 14,
// //                             color: AppColors.yellow,
// //                           ),
// //                           filled: true,
// //                           fillColor: Colors.white,
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                             borderSide: BorderSide.none,
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             // Bordure quand le champ est sélectionné
// //                             borderSide: BorderSide(
// //                               color: AppColors
// //                                   .yellow, // Couleur de la bordure active
// //                               width: 1.0,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       ElevatedButton.icon(
// //                         onPressed: () async {
// //                           final ImagePicker picker = ImagePicker();
// //                           final XFile? image = await picker.pickImage(
// //                               source: ImageSource.gallery);
// //                           if (image != null) {
// //                             setState(() {
// //                               selectedImage = image;
// //                             });
// //                           }
// //                         },
// //                         icon: Icon(Icons.photo, color: Colors.white),
// //                         label: Text(
// //                           "Joindre une image",
// //                           style: TextStyle(
// //                               color: Colors.white, fontWeight: FontWeight.w400),
// //                         ),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor:
// //                               AppColors.yellow.withValues(alpha: 0.5),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           minimumSize:
// //                               Size(MediaQuery.sizeOf(context).width, 40),
// //                         ),
// //                       ),
// //                       if (selectedImage != null) ...[
// //                         const SizedBox(height: 10),
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(10),
// //                           child: Image.file(
// //                             File(selectedImage!.path),
// //                             height: 100,
// //                           ),
// //                         ),
// //                       ],
// //                       const SizedBox(height: 10),
// //                       Row(
// //                         children: [
// //                           Expanded(
// //                             child: ElevatedButton(
// //                               onPressed: () {
// //                                 // logiques de validation ou d'envoi ici
// //                                 Navigator.of(context).pop();
// //                               },
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor:
// //                                     AppColors.yellow.withValues(alpha: 0.6),
// //                                 padding:
// //                                     const EdgeInsets.symmetric(vertical: 10),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(30),
// //                                 ),
// //                               ),
// //                               child: Text(
// //                                 "Confirmer",
// //                                 style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontWeight: FontWeight.bold),
// //                               ),
// //                             ),
// //                           ),
// //                           const SizedBox(width: 12),
// //                           Expanded(
// //                             child: OutlinedButton(
// //                               onPressed: () {
// //                                 Navigator.of(context).pop();
// //                               },
// //                               style: OutlinedButton.styleFrom(
// //                                 padding:
// //                                     const EdgeInsets.symmetric(vertical: 10),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(30),
// //                                 ),
// //                                 side: BorderSide(color: Colors.white),
// //                                 backgroundColor: Colors.white,
// //                               ),
// //                               child: Text(
// //                                 "Abandonner",
// //                                 style: TextStyle(
// //                                     color: Colors.grey[500],
// //                                     fontWeight: FontWeight.w400),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   void showRejeterDialog(BuildContext context) {
// //     final TextEditingController motifController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return Dialog(
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(16),
// //           ),
// //           child: Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 // Icône d'alerte
// //                 Container(
// //                   width: 48,
// //                   height: 48,
// //                   decoration: BoxDecoration(
// //                     border: Border.all(color: Colors.red, width: 2),
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: Center(
// //                     child: Icon(Icons.error_outlined, color: Colors.red),
// //                   ),
// //                 ),
// //                 SizedBox(height: 16),

// //                 // Titre en rouge
// //                 Text(
// //                   "Pourquoi souhaitez-vous\nannuler cette dépense ?",
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.w500,
// //                     fontSize: 18,
// //                     color: Colors.red,
// //                   ),
// //                 ),
// //                 SizedBox(height: 16),

// //                 // Champ Motif
// //                 TextField(
// //                   controller: motifController,
// //                   maxLines: 3,
// //                   decoration: InputDecoration(
// //                     hintText: "Motif (obligatoire)",
// //                     hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     contentPadding: EdgeInsets.all(12),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                     focusedBorder: OutlineInputBorder(
// //                       // Bordure quand le champ est sélectionné
// //                       borderSide: BorderSide(
// //                         color: Colors.redAccent, // Couleur de la bordure active
// //                         width: 1.0,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),

// //                 // Boutons
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   children: [
// //                     // Bouton Confirmer
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         // logique de confirmation
// //                         Navigator.of(context).pop();
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.redAccent,
// //                         foregroundColor: Colors.white,
// //                         padding:
// //                             EdgeInsets.symmetric(horizontal: 24, vertical: 10),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(30),
// //                         ),
// //                       ),
// //                       child: Text("Confirmer"),
// //                     ),

// //                     // Bouton Abandonner
// //                     TextButton(
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       style: TextButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: Colors.grey,
// //                         padding:
// //                             EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(30),
// //                         ),
// //                       ),
// //                       child: Text(
// //                         "Abandonner",
// //                         style: TextStyle(fontWeight: FontWeight.w400),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final String day = DateFormat('d', 'fr_FR').format(date);
// //     final String month = DateFormat('MMM', 'fr_FR').format(date).toUpperCase();

// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => DetailsDepense(
// //               date: date,
// //               montant: montant,
// //               categorie: categorie,
// //               description: description,
// //               demandeur: "HOUNKPATIN ESTELLE ",
// //               //motif: "Frais de livraison", // À adapter selon vos besoins
// //             ),
// //           ),
// //         );
// //       },
// //       child: Card(
// //         shadowColor: Colors.white,
// //         color: Colors.white,
// //         //Colors.blue.shade400,
// //         //Color.fromARGB(255, 213, 209, 243),
// //         elevation: 1,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 0.0),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               const SizedBox(width: 12),
// //               //content
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(description,
// //                         maxLines: 2,
// //                         style: TextStyle(
// //                           color: AppColors.yellow.withValues(alpha: 0.8),
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.w400,
// //                           //height: 0
// //                         )),
// //                     Text(
// //                       NumberFormat.currency(
// //                         locale: 'fr_FR', // Pour français
// //                         symbol: 'FCFA', // Ou '€', '$', etc.
// //                         decimalDigits:
// //                             0, // Supprime les décimales si non nécessaires
// //                       ).format(montant),
// //                       style: const TextStyle(
// //                         color: AppColors.yellow,
// //                         fontSize: 20,
// //                       ),
// //                     ),
// //                     Text("Catégorie : $categorie",
// //                         style: const TextStyle(
// //                           fontStyle: FontStyle.italic,
// //                           color: Colors.grey,
// //                         )),
// //                     // Row(
// //                     //   mainAxisSize: MainAxisSize.min,
// //                     //   crossAxisAlignment: CrossAxisAlignment.center,
// //                     //   children: [
// //                     //     ElevatedButton(
// //                     //       onPressed: () {
// //                     //         showRejeterDialog(context);
// //                     //       },
// //                     //       // icon: const Icon(Icons.cancel,
// //                     //       //     color: Colors.redAccent, size: 16),
// //                     //       style: TextButton.styleFrom(
// //                     //         shape: RoundedRectangleBorder(
// //                     //             borderRadius: BorderRadius.circular(5)),
// //                     //         backgroundColor:
// //                     //             const Color.fromARGB(255, 255, 231, 231),
// //                     //         padding: EdgeInsets.symmetric(
// //                     //             horizontal: 10, vertical: 3),
// //                     //         minimumSize: Size(0, 0),
// //                     //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                     //       ),
// //                     //       child: Row(
// //                     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     //         children: [
// //                     //           const Icon(Icons.cancel,
// //                     //               color: Colors.redAccent, size: 16),
// //                     //           const SizedBox(
// //                     //             width: 6,
// //                     //           ),
// //                     //           Text('Rejeter',
// //                     //               style: TextStyle(
// //                     //                   color: Colors.redAccent, fontSize: 12)),
// //                     //         ],
// //                     //       ),
// //                     //     ),
// //                     //     const SizedBox(width: 16),
// //                     //     ElevatedButton(
// //                     //       onPressed: () {
// //                     //         showApprouverDialog(context);
// //                     //       },
// //                     //       style: TextButton.styleFrom(
// //                     //         shape: RoundedRectangleBorder(
// //                     //             borderRadius: BorderRadius.circular(5)),
// //                     //         backgroundColor:
// //                     //             const Color.fromARGB(255, 212, 255, 214),
// //                     //         padding: EdgeInsets.symmetric(
// //                     //             horizontal: 10, vertical: 3),
// //                     //         minimumSize: Size(0, 0),
// //                     //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                     //       ),
// //                     //       child: Row(
// //                     //         children: [
// //                     //           const Icon(Icons.check_circle,
// //                     //               color: Colors.green, size: 16),
// //                     //           const Text('Valider',
// //                     //               style: TextStyle(
// //                     //                   color: Colors.green, fontSize: 12)),
// //                     //         ],
// //                     //       ),
// //                     //     ),
// //                     //   ],
// //                     // ),
// //                     const SizedBox(
// //                       height: 5,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(width: 5),
// //               //left
// //               Container(
// //                 width: 40,
// //                 height: 40,
// //                 decoration: BoxDecoration(
// //                   color: AppColors.yellow.withValues(alpha: 0.1),
// //                   borderRadius: BorderRadius.circular(24),
// //                 ),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(day,
// //                         style: const TextStyle(
// //                             fontWeight: FontWeight.w400,
// //                             fontSize: 8,
// //                             color: AppColors.yellow)),
// //                     Text(month,
// //                         style: const TextStyle(
// //                             fontWeight: FontWeight.w400,
// //                             fontSize: 8,
// //                             color: AppColors.yellow)),
// //                   ],
// //                 ),
// //               ),

// //               // const Icon(
// //               //     Icons.work,
// //               //     size: 36,
// //               //     color: Colors.white,
// //               //   ),
// //               //
// //               SizedBox(
// //                 width: 12,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:expense_manager/constants/colors.dart';
// import 'package:expense_manager/pages/details_depense.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class DepenseCard extends StatelessWidget {
//   final DateTime date;
//   final String categorie;
//   final String description;
//   final int montant;
//   final bool isRejected;

//   const DepenseCard({
//     super.key,
//     required this.date,
//     required this.categorie,
//     required this.description,
//     required this.montant,
//     this.isRejected = false,
//   });

//   void showApprouverDialog(BuildContext context) {
//     final TextEditingController motifController = TextEditingController();
//     XFile? selectedImage;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           // pour gérer setState dans la boîte
//           builder: (context, setState) {
//             return Dialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               backgroundColor: Colors.blue.shade100,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Icône d'alerte
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.yellow, width: 2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Icon(Icons.check, color: AppColors.yellow),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         "Pourriez-vous indiquer le\nmotif de votre approbation ?",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppColors.yellow,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: motifController,
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           hintText: "Motif (facultatif)",
//                           hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: AppColors.yellow,
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             // Bordure quand le champ est sélectionné
//                             borderSide: BorderSide(
//                               color: AppColors
//                                   .yellow, // Couleur de la bordure active
//                               width: 1.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       ElevatedButton.icon(
//                         onPressed: () async {
//                           final ImagePicker picker = ImagePicker();
//                           final XFile? image = await picker.pickImage(
//                               source: ImageSource.gallery);
//                           if (image != null) {
//                             setState(() {
//                               selectedImage = image;
//                             });
//                           }
//                         },
//                         icon: Icon(Icons.photo, color: Colors.white),
//                         label: Text(
//                           "Joindre une image",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.w400),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               AppColors.yellow.withValues(alpha: 0.5),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           minimumSize:
//                               Size(MediaQuery.sizeOf(context).width, 40),
//                         ),
//                       ),
//                       if (selectedImage != null) ...[
//                         const SizedBox(height: 10),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.file(
//                             File(selectedImage!.path),
//                             height: 100,
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // logiques de validation ou d'envoi ici
//                                 Navigator.of(context).pop();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor:
//                                     AppColors.yellow.withValues(alpha: 0.6),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Confirmer",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 side: BorderSide(color: Colors.white),
//                                 backgroundColor: Colors.white,
//                               ),
//                               child: Text(
//                                 "Abandonner",
//                                 style: TextStyle(
//                                     color: Colors.grey[500],
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void showRejeterDialog(BuildContext context) {
//     final TextEditingController motifController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Icône d'alerte
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.red, width: 2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Icon(Icons.error_outlined, color: Colors.red),
//                   ),
//                 ),
//                 SizedBox(height: 16),

//                 // Titre en rouge
//                 Text(
//                   "Pourquoi souhaitez-vous\nannuler cette dépense ?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.red,
//                   ),
//                 ),
//                 SizedBox(height: 16),

//                 // Champ Motif
//                 TextField(
//                   controller: motifController,
//                   maxLines: 3,
//                   decoration: InputDecoration(
//                     hintText: "Motif (obligatoire)",
//                     hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: EdgeInsets.all(12),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       // Bordure quand le champ est sélectionné
//                       borderSide: BorderSide(
//                         color: Colors.redAccent, // Couleur de la bordure active
//                         width: 1.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Boutons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Bouton Confirmer
//                     ElevatedButton(
//                       onPressed: () {
//                         // logique de confirmation
//                         Navigator.of(context).pop();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         foregroundColor: Colors.white,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Text("Confirmer"),
//                     ),

//                     // Bouton Abandonner
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.grey,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Text(
//                         "Abandonner",
//                         style: TextStyle(fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String day = DateFormat('d', 'fr_FR').format(date);
//     final String month = DateFormat('MMM', 'fr_FR').format(date).toUpperCase();

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DetailsDepense(
//               date: date,
//               montant: montant,
//               categorie: categorie,
//               description: description,
//               demandeur: "HOUNKPATIN ESTELLE ",
//               //motif: "Frais de livraison", // À adapter selon vos besoins
//             ),
//           ),
//         );
//       },
//       child: Container(
//         //Colors.blue.shade400,
//         //Color.fromARGB(255, 213, 209, 243),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(0),
//           color: //Colors.white,
//           Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 0.0),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(width: 20),
//                   //content
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 0,),
//                         Text(description,
//                             maxLines: 2,
//                             style: TextStyle(
//                               color: //AppColors.yellow.withValues(alpha: 0.8),
//                               Colors.grey,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               //height: 0
//                             )),
//                         Text("Catégorie : $categorie",
//                             style: const TextStyle(
//                               fontStyle: FontStyle.italic,
//                               color: Colors.grey,
//                             )),
//                         Text(
//                           NumberFormat.currency(
//                             locale: 'fr_FR', // Pour français
//                             symbol: 'FCFA', // Ou '€', '$', etc.
//                             decimalDigits:
//                                 0, // Supprime les décimales si non nécessaires
//                           ).format(montant),
//                           style: const TextStyle(
//                             color: AppColors.yellow,
//                             fontSize: 16,
//                           ),
//                         ),
//                         // Row(
//                         //   mainAxisSize: MainAxisSize.min,
//                         //   crossAxisAlignment: CrossAxisAlignment.center,
//                         //   children: [
//                         //     ElevatedButton(
//                         //       onPressed: () {
//                         //         showRejeterDialog(context);
//                         //       },
//                         //       // icon: const Icon(Icons.cancel,
//                         //       //     color: Colors.redAccent, size: 16),
//                         //       style: TextButton.styleFrom(
//                         //         shape: RoundedRectangleBorder(
//                         //             borderRadius: BorderRadius.circular(5)),
//                         //         backgroundColor:
//                         //             const Color.fromARGB(255, 255, 231, 231),
//                         //         padding: EdgeInsets.symmetric(
//                         //             horizontal: 10, vertical: 3),
//                         //         minimumSize: Size(0, 0),
//                         //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         //       ),
//                         //       child: Row(
//                         //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //         children: [
//                         //           const Icon(Icons.cancel,
//                         //               color: Colors.redAccent, size: 16),
//                         //           const SizedBox(
//                         //             width: 6,
//                         //           ),
//                         //           Text('Rejeter',
//                         //               style: TextStyle(
//                         //                   color: Colors.redAccent, fontSize: 12)),
//                         //         ],
//                         //       ),
//                         //     ),
//                         //     const SizedBox(width: 16),
//                         //     ElevatedButton(
//                         //       onPressed: () {
//                         //         showApprouverDialog(context);
//                         //       },
//                         //       style: TextButton.styleFrom(
//                         //         shape: RoundedRectangleBorder(
//                         //             borderRadius: BorderRadius.circular(5)),
//                         //         backgroundColor:
//                         //             const Color.fromARGB(255, 212, 255, 214),
//                         //         padding: EdgeInsets.symmetric(
//                         //             horizontal: 10, vertical: 3),
//                         //         minimumSize: Size(0, 0),
//                         //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         //       ),
//                         //       child: Row(
//                         //         children: [
//                         //           const Icon(Icons.check_circle,
//                         //               color: Colors.green, size: 16),
//                         //           const Text('Valider',
//                         //               style: TextStyle(
//                         //                   color: Colors.green, fontSize: 12)),
//                         //         ],
//                         //       ),
//                         //     ),
//                         //   ],
//                         // ),
//                         const SizedBox(
//                           height: 0,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   //left
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: //AppColors.yellow.withValues(alpha: 0.1),
//                       Colors.grey[100],
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(day,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 8,
//                                 color: AppColors.yellow)),
//                         Text(month,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 8,
//                                 color: AppColors.yellow)),
//                       ],
//                     ),
//                   ),

//                   // const Icon(
//                   //     Icons.work,
//                   //     size: 36,
//                   //     color: Colors.white,
//                   //   ),
//                   //
//                   SizedBox(
//                     width: 20,
//                   ),
//                 ],
//               ),
//               Divider(
//                 color: Colors.amber,
//                 indent: 0,
//                 endIndent: 0,
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
