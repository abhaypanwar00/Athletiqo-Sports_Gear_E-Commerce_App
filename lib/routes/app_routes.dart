import 'package:athletiqo/common/shared/authentication/screens/login/login.dart';
import 'package:athletiqo/common/shared/authentication/screens/password_config/forget_password.dart';
import 'package:athletiqo/common/shared/authentication/screens/signup/signup.dart';
import 'package:athletiqo/common/shared/authentication/screens/signup/verify_email.dart';
import 'package:athletiqo/common/shared/onboarding/onboarding_screen.dart';
import 'package:athletiqo/modules/admin/shop/screens/add_product/add_product_screen.dart';
import 'package:athletiqo/modules/customer/personalization/screens/settings/settings_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/cart/cart_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/home/home_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/store/store_screen.dart';
import 'package:athletiqo/modules/customer/shop/screens/wishlist/wishlist_screen.dart';
import 'package:athletiqo/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    // Home Screen
    GetPage(name: Routes.home, page: () => const HomeScreen()),

    // Store Screen
    GetPage(name: Routes.store, page: () => StoreScreen()),

    // Wishlist Screen
    GetPage(name: Routes.wishlist, page: () => const WishlistScreen()),

    // Settings Screen
    GetPage(name: Routes.settings, page: () => const SettingsScreen()),

    // Add Product Screen
    GetPage(
      name: Routes.addProduct,
      page: () => AddProductScreen(),
      // binding: ProductBinding(),
    ),

    // // Products Reviews Screen
    // GetPage(
    //   name: Routes.productReviews,
    //   page: () => const ProductReviewsScreen(),
    // ),

    // // Order Screen
    // GetPage(
    //   name: Routes.order,
    //   page: () => const OrderScreen(),
    // ),

    // // Checkout Screen
    // GetPage(
    //   name: Routes.checkout,
    //   page: () => const CheckoutScreen(),
    // ),

    // Cart Screen
    GetPage(name: Routes.cart, page: () => const CartScreen()),

    // // Profile Screen
    // GetPage(
    //   name: Routes.userProfile,
    //   page: () => const ProfileScreen(),
    // ),

    // // Address Screen
    // GetPage(
    //   name: Routes.userAddress,
    //   page: () => const AddressScreen(),
    // ),

    // Signup Screen
    GetPage(name: Routes.signup, page: () => const SignupScreen()),

    // Verify Email Screen
    GetPage(name: Routes.verifyEmail, page: () => const VerifyEmailScreen()),

    // Signin Screen
    GetPage(name: Routes.signin, page: () => const LoginScreen()),

    // Forget Password Screen
    GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),

    // Onboarding Screen
    GetPage(name: Routes.onBoarding, page: () => const OnboardingScreen()),
  ];
}
