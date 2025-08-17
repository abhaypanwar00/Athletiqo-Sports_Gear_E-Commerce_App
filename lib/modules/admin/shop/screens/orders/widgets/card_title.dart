
import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({super.key, required this.cardTitle});

  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      cardTitle,
      style: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
    );
  }
}