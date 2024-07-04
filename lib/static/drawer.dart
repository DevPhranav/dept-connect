import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/authentication/auth/data/models/auth_user_model.dart';
import '../src/authentication/auth/presentation/blocs/sign_out/sign_out_bloc.dart';
import '../src/authentication/auth/presentation/blocs/sign_out/sign_out_event.dart';
import '../src/authentication/auth/presentation/blocs/sign_out/sign_out_state.dart';

class DeptDrawer extends StatelessWidget {
  final AuthUserModel? user;

  const DeptDrawer({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocListener<SignOutBloc, SignOutState>(
        listener: (context, state) {
          if (state is SignOutInProgress) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is SignOutSuccess) {
            Navigator.of(context).pop(); // Dismiss the progress dialog
            // Navigate to login page
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          } else if (state is SignOutFailure) {
            Navigator.of(context).pop(); // Dismiss the progress dialog
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign out failed')),
            );
          }
        },
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_rounded,
                    size: 50,
                  ),
                  Text(user?.name ?? ""),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.space_dashboard),
              title: const Text("Space"),
              splashColor: Colors.grey[150],
              onTap: () {
                final currentRoute = ModalRoute.of(context)?.settings.name;

                if (user?.userType == "Teacher") {
                  if (currentRoute == "/hod_space") {
                    Navigator.pop(context);
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName("/hod_space"));
                  }
                } else if (user?.userType == "Student") {
                  if (currentRoute == "/student_space") {
                    Navigator.pop(context);
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName("/student_space"));
                  }
                }
              },
            ),
            if (user?.userType != "Student")
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text("Requests"),
                onTap: () {},
              ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Logout', style: TextStyle(color: Colors.black)),
                      content: const Text('Are you sure you want to logout?'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Logout', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the confirmation dialog
                            BlocProvider.of<SignOutBloc>(context).add(SignOutRequested());
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
