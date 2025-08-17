import 'package:athletiqo/common/widgets/images/circular_image.dart';
import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/common/widgets/text/section_heading.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/user_controller.dart';
import 'package:athletiqo/modules/customer/personalization/screens/profile/update_name_screen.dart';
import 'package:athletiqo/modules/customer/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/constants/image_strings.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/loaders/shimmer_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: Appbar(showBackArrow: true, title: "Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty
                              ? networkImage
                              : AppImages.user;
                      return controller.imageUploading.value
                          ? ShimmerEffect(width: 80, height: 80)
                          : CircularImage(
                            image: image,
                            width: 80,
                            height: 80,
                            padding: 0,
                            isNetworkImage: networkImage.isNotEmpty,
                          );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: Text(
                        "Change Profile Picture",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.apply(color: AppColors.lime),
                      ),
                    ),
                  ],
                ),
              ),

              // Details
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),

              // Profile Information
              SectionHeading(text: "Profile Information"),
              SizedBox(height: AppSizes.spaceBtwItems),

              /// Name
              Obx(
                () => ProfileMenu(
                  title: "Name",
                  value: controller.user.value.fullName,
                  onTap: () async {
                    final result = await Get.to(() => const UpdateNameScreen());
                    if (result == true) {
                      controller.user.refresh();
                    }
                  },
                ),
              ),

              /// Username
              ProfileMenu(
                title: "Username",
                value: controller.user.value.username,
                onTap: () {},
              ),

              SizedBox(height: AppSizes.spaceBtwItems),
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),

              // Personal Information
              SectionHeading(text: "Personal Information"),
              SizedBox(height: AppSizes.spaceBtwItems),

              /// User ID
              ProfileMenu(
                title: "User ID",
                value: controller.user.value.id,
                onTap: () {},
                icon: Iconsax.copy,
              ),

              /// Email
              ProfileMenu(
                title: "Email",
                value: controller.user.value.email,
                onTap: () {},
              ),

              /// Phone Number
              ProfileMenu(
                title: "Phone Number",
                value: controller.user.value.phoneNumber,
                onTap: () {},
              ),

              /// Gender
              ProfileMenu(title: "Gender", value: "Male", onTap: () {}),

              /// Date of Birth
              ProfileMenu(
                title: "Date of Birth",
                value: "01 Sep, 2003",
                onTap: () {},
              ),

              SizedBox(height: AppSizes.spaceBtwItems),
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),

              // Delete Account Button
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(
                    "Delete Account",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
