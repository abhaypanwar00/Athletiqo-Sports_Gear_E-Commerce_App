import 'package:athletiqo/bindings/general_bindings.dart';
import 'package:athletiqo/routes/app_routes.dart';
import 'package:athletiqo/utils/constants/colors.dart';
import 'package:athletiqo/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Athletiqo',
      themeMode: ThemeMode.system,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
