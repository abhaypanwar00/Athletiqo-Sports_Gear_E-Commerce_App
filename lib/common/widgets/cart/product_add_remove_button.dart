import 'package:athletiqo/common/widgets/icon/circular_icon.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddOrRemoveProductButton extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int quantity;
  final Color? color, minusIconColor, textColor, addIconContainerColor;

  const AddOrRemoveProductButton({
    super.key,
    required this.onAdd,
    required this.onRemove,
    required this.quantity,
    this.color,
    this.minusIconColor,
    this.textColor,
    this.addIconContainerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.sm,
        horizontal: AppSizes.iconXs,
      ),
      decoration: BoxDecoration(
        color: color ?? AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppSizes.lg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Iconsax.minus,
              color: minusIconColor ?? AppColors.black,
            ),
          ),
          SizedBox(width: AppSizes.spaceBtwItems),
          Text(
            "$quantity",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: textColor ?? AppColors.black,
            ),
          ),
          SizedBox(width: AppSizes.spaceBtwItems),
          GestureDetector(
            onTap: onAdd,
            child: CircularIcon(
              icon: Iconsax.add,
              width: 30,
              height: 30,
              size: 15,
              iconColor: AppColors.white,
              backgroundColor: addIconContainerColor ?? AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
