import 'dart:io';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/error_text.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductImagePicker extends StatelessWidget {
  const ProductImagePicker({
    super.key,
    required this.images,
    required this.controller,
    required this.color,
  });

  final List<String> images;
  final AddProductController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image display and removal
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...images.map(
              (path) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(path),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () => controller.removeImage(color, path),
                    ),
                  ),
                ],
              ),
            ),
            // Add image button if fewer than 5 images
            if (images.length < 5)
              GestureDetector(
                onTap: () => controller.pickImages(color),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add_a_photo, color: Colors.white),
                ),
              ),
          ],
        ),
        // Error message if no images are selected
        if (controller.imageError.isNotEmpty)
          ErrorText(controller: controller, text: controller.imageError.value),
      ],
    );
  }
}
