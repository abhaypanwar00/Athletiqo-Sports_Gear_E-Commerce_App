import 'package:athletiqo/app.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:athletiqo/data/repository/user/user_repo.dart';
import 'package:athletiqo/firebase_options.dart';
import 'package:athletiqo/modules/customer/repository/cart_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Local Storage
  await GetStorage.init();

  // Await splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // User Repository
  Get.put(UserRepository());

  // Cart Repository
  Get.put(CartRepository());

  runApp(const App());
}
