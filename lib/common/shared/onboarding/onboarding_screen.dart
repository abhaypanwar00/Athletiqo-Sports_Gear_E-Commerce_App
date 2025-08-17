import 'package:athletiqo/common/shared/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background scattered images
          Positioned(
            top: 60,
            left: 20,
            child: roundedImage("assets/onboarding/fitness_top.avif", 230, 350),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: roundedImage(
              "assets/onboarding/cross_body_bag.avif",
              140,
              180,
            ),
          ),
          Positioned(
            top: 260,
            right: 20,
            child: roundedImage("assets/onboarding/nike_cap.avif", 145, 145),
          ),
          Positioned(
            bottom: 330,
            left: 20,
            child: roundedImage(
              "assets/onboarding/water_bottle.webp",
              100,
              180,
            ),
          ),
          Positioned(
            bottom: 330,
            right: 20,
            child: roundedImage("assets/onboarding/gym_bag.avif", 280, 180),
          ),
          // Center message + Get Started Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFF89F336),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Find everything you need for sports",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "From gym to game day, we’ve got you covered.\nShop the latest gear and apparel.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final deviceStorage = GetStorage();
                      deviceStorage.write('isFirstTime', false);
                      Get.offAll(() => LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text(
                      "Get Started",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget roundedImage(String path, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(path, fit: BoxFit.fitHeight),
      ),
    );
  }
}
