import 'package:athletiqo/common/widgets/container/rounded_container.dart';
import 'package:athletiqo/modules/customer/personalization/models/address_model.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.selectedAddress,
  });

  final AddressModel address;
  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: EdgeInsets.all(AppSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress ? AppColors.lime.withOpacity(0.4) : Colors.transparent,
      borderColor: selectedAddress ? Colors.transparent : AppColors.darkGrey,
      margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Stack(
        children: [
          if (selectedAddress)
            const Positioned(
              right: 5,
              top: 0,
              child: Icon(Iconsax.tick_circle5, color: AppColors.lime),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name, style: Theme.of(context).textTheme.titleLarge),
               SizedBox(height: AppSizes.sm / 2),
              Text(address.phone),
              SizedBox(height: AppSizes.sm / 2),
              Text("${address.street}, ${address.city}, ${address.state} - ${address.postalCode}"),
            ],
          ),
        ],
      ),
    );
  }
}