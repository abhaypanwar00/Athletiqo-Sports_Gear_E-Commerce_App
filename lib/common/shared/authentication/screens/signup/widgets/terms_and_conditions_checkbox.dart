import 'package:athletiqo/common/shared/authentication/controllers/signup/signup_controller.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionCheckbox extends StatelessWidget {
  const TermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        SizedBox(width: AppSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${AppTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${AppTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: AppColors.white,
                  decorationColor: AppColors.white,
                ),
              ),
              TextSpan(
                text: 'and',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${AppTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: AppColors.white,
                  decorationColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
