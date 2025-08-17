import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PriceAndHexCode extends StatelessWidget {
  const PriceAndHexCode({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Price
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextHeading(text: "Price"),
              SizedBox(height: AppSizes.sm),
              TextFormField(onChanged: (val) => details['price'] = val),
            ],
          ),
        ),
        SizedBox(width: AppSizes.spaceBtwInputFields),
        // Hex Code
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextHeading(text: "Hex Code"),
              SizedBox(height: AppSizes.sm),
              TextFormField(onChanged: (val) => details['hex'] = val),
            ],
          ),
        ),
      ],
    );
  }
}
