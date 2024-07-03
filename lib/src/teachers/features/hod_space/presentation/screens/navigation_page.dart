import 'package:flutter/material.dart';

import '../../../auth/data/models/auth_user_model.dart';

class NavigationScreen extends StatelessWidget {

  final AuthUserModel? user;

  const NavigationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user!.role == 'HOD') {
        Navigator.pushReplacementNamed(context, '/hod_space');
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color:Colors.black),
      ),
    );
  }
}