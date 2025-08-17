import 'package:athletiqo/common/widgets/container/rounded_container.dart';
import 'package:athletiqo/common/widgets/text/section_heading.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BillingPaymentMethod extends StatelessWidget {
  const BillingPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          text: "Payment Method",
          showActionButton: true,
          buttonTitle: "",
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            RoundedContainer(
              backgroundColor: Colors.transparent,
              width: 50,
              height: 50,
              padding: EdgeInsets.all(AppSizes.sm),
              child: Image(
                image: AssetImage('assets/payment_methods/cod.png'),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems / 2),
            Text(
              "Cash on Delivery",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
