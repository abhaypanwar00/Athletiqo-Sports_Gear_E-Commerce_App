import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, required this.label, required this.value});

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.lightGrey,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Value
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.end, // or TextAlign.start if preferred
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
