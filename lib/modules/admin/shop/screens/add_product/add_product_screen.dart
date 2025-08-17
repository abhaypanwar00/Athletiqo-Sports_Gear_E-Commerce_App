import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/text/text_heading.dart';
import 'package:athletiqo/modules/admin/shop/controllers/add_product/add_product_controller.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/bulk_discount_details.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/category_chip.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/color_picker.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/color_variant_details.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/gender_chip.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/return_policy_chips.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/widgets/subcategories_chip.dart';
import 'package:athletiqo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athletiqo/utils/constants/sizes.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Add Product', showBackArrow: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          key: controller.addProductFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              const TextHeading(text: "Product Name"),
              SizedBox(height: AppSizes.sm),
              TextFormField(
                controller: controller.productName,
                validator:
                    (value) =>
                        AppValidator.validateEmptyText('Product Name', value),
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Brand Name
              const TextHeading(text: "Brand"),
              SizedBox(height: AppSizes.sm),
              TextFormField(
                controller: controller.brandName,
                validator:
                    (value) =>
                        AppValidator.validateEmptyText('Brand Name', value),
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Description
              const TextHeading(text: "Description"),
              SizedBox(height: AppSizes.sm),
              TextFormField(
                controller: controller.description,
                minLines: 3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator:
                    (value) =>
                        AppValidator.validateEmptyText('Description', value),
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Category
              const TextHeading(text: "Category"),
              SizedBox(height: AppSizes.sm),
              CategoryChip(),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Gender
              const TextHeading(text: "Gender"),
              SizedBox(height: AppSizes.sm),
              GenderChip(),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Sub-Categories
              SubcategoriesChip(),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Colors Selection
              const TextHeading(text: "Colors"),
              SizedBox(height: AppSizes.sm),
              ProductColorPicker(),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Price, Stock, Size and Image of Selected Color
              ColorVariantDetails(),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Loyalty Points
              TextHeading(text: "Loyalty Points"),
              SizedBox(height: AppSizes.sm),
              TextFormField(
                controller: controller.loyaltyPoints,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Bulk Discount
              TextHeading(text: "Bulk Discount"),
              SizedBox(height: AppSizes.sm),
              BulkDiscountDetails(),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              // Return Policy
              const TextHeading(text: "Return Policy"),
              SizedBox(height: AppSizes.sm),
              ReturnPolicyChips(),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Submit Button
              ElevatedButton(
                onPressed: () => controller.uploadAndSubmitProduct(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Obx(
                  () =>
                      controller.isLoading.value
                          ? Text('Publishing...')
                          : Text('Publish to Store'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
