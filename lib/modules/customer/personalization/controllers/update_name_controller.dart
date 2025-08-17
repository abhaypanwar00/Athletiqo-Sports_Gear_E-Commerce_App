import 'package:athletiqo/data/repository/user/user_repo.dart';
import 'package:athletiqo/modules/customer/personalization/controllers/user_controller.dart';
import 'package:athletiqo/utils/helpers/network_manager.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // AppFullScreenLoader.stopLoading();
        return;
      }

      // Update users first and last name in the database
      Map<String, dynamic> name = {
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      // Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      userController.user.refresh();

      // Stop Loading
      // AppFullScreenLoader.stopLoading();

      // Move back to the profile screen
      Get.back(result: true);

      // Show success message
      AppLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your name has been updated successfully",
      );
    } catch (e) {
      // Stop Loading
      // AppFullScreenLoader.stopLoading();

      // Show error message
      AppLoaders.errorSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }
}
