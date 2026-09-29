
import 'package:expense_manager/config/clippers.dart';
import 'package:expense_manager/config/colors.dart';

import './login_page_controller.dart';
import './text_content.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginPageController controller = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //Couleur de la page
        backgroundColor: Colors.white,

        body: Column(
          children: [
            //Patie haute de la page(logo)
            Expanded(
              flex: 4,
              child: Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/somimas.jpg',
                    width: MediaQuery.of(context).size.width * 0.53, //pour gérer la déformation de l'image lors du défilement
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Partie basse (champs de formulaire & bouton)
            Expanded(
              flex: 6,
              child: ClipPath(
                clipper: TopCurveClipper(), // clipper à appliquer au container
                child: SingleChildScrollView(
                  child: Container(
                    color: AppColors.primary,
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          LoginPageTextContent.welcomeTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        Text(
                          LoginPageTextContent.welcomeSubtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Champ email
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: LoginPageTextContent.emailLabel,
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white24),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Champ mot de passe
                        TextField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: LoginPageTextContent.passwordLabel,
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white24),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Bouton
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.navigateToNextScreen();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              LoginPageTextContent.loginButton,
                              style: const TextStyle(
                                fontSize: 16, 
                                color: AppColors.primary
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Mot de passe oublié
                      //   Center(
                      //     child: TextButton(
                      //       onPressed: () {},
                      //       child: Text(
                      //         LoginPageTextContent.forgotPassword,
                      //         style: const TextStyle(
                      //           color: Colors.white54,
                      //           decoration: TextDecoration.underline,
                      //           decorationColor: Colors.white
                      //         ),
                      //       ),
                      //     ),
                      //   )
                      // 
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}