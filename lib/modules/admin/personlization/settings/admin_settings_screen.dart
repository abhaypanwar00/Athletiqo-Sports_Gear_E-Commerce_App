import 'package:athletiqo/common/widgets/navigation/app_bar.dart';
import 'package:athletiqo/data/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Settings'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Admin", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
