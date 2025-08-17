import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.controller, required this.text});

  final AddProductController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.red),
      ),
    );
  }
}
