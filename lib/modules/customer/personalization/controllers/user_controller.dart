import 'package:athletiqo/common/shared/authentication/screens/login/login.dart';
import 'package:athletiqo/data/models/user_models.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/data/repository/user/user_repo.dart';
import 'package:athletiqo/modules/customer/personalization/screens/profile/re_auth_login_form.dart';
import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/helpers/network_manager.dart';
import 'package:athletiqo/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = true.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // Refresh user record
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Convert name to first and last name
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');

          // Generate username
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredential.user!.uid,
            username: username,
            email: userCredential.user!.email ?? '',
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
            role: 'customer'
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      AppLoaders.warningSnackBar(
        title: "Data not saved",
        message:
            "Something went wrong while saving your information. You can re-save your data in your profile.",
      );
    }
  }

  // Upload profile image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImageToCloudinary(
          'UrbanCartel/Users/Images/ProfilePicture',
          image,
        );

        // Update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl.toString();
        user.refresh();

        AppLoaders.successSnackBar(
          title: "Congratulations",
          message: "Your profile image has been updated!",
        );
      }
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: "Oh Snap!",
        message: 'Something went wrong : $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }

  // Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.all(AppSizes.lg),
      contentPadding: EdgeInsets.only(
        left: AppSizes.lg,
        right: AppSizes.lg,
        bottom: AppSizes.lg,
      ),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account? This action is not reversible and all of your data will be removed permanentely.",
      confirm: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop();
          deleteUserAccount();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: const Text("Delete"),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text("Cancel"),
      ),
    );
  }

  // Delete user account
  void deleteUserAccount() async {
    try {
      // start loading

      // Re-Authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re-verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          // stop loading
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          // stop loading
          Get.to(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      // stop loading
      AppLoaders.warningSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }

  // Re-Authenticate email and password
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      // start loading

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loading
        return;
      }

      // Validate Check
      if (!reAuthFormKey.currentState!.validate()) {
        // stop loading
        return;
      }

      // Re-Authenticate user
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await AuthenticationRepository.instance.deleteAccount();
      // stop loading
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      // stop loading
      AppLoaders.warningSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }
}
