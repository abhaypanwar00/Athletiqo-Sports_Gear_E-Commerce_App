import 'package:athletiqo/common/widgets/styles/spacing_styles.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onPressed,
  });

  final String image, title, subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Success Animation
              Lottie.asset(
                width: AppHelperFunctions.screenWidth() * 0.6,
                image,
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              // Title and Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              // Buttons
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
