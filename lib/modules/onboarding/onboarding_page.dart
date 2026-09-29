import '../../config/colors.dart';
import 'onboarding_controller.dart';
import '../../config/clippers.dart';
import 'text_content.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Couleur de la page
      backgroundColor: Colors.white,

      //Body de la page
      body: Column(
        children: [
          //Partie haute de la page (image)
          Expanded(
            flex: 5,
            child: Center(
              child: Image.asset(
                'assets/images/count.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          ),

          //Partie basse de la page (texte & bouton)
          Expanded(
            flex: 4,
            child: ClipPath(
              clipper: TopCurveClipper(), // type de forme à appliquer au container
              child: Container(
                width: double.infinity,
                color: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      OnboardingTextContent.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    const Text(
                      OnboardingTextContent.subtitle,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.navigateToNextScreen();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              OnboardingTextContent.buttonText,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}