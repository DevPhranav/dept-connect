import 'package:flutter/material.dart';
import 'package:miniproject_authentication/src/features/auth/data/models/auth_user_model.dart';
import '../../../../../static/hod_drawer.dart';

class HomeScreen extends StatelessWidget {
  final AuthUserModel? user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user?.email ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('ID: ${user?.id ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Department: ${user?.department ?? 'N/A'}'),
          ],
        ),
      ),
      drawer: const HodDrawer(userName: "hello"),
    );
  }
}
