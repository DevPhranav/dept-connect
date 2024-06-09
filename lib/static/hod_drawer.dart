import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/features/auth/presentation/blocs/sign_out/sign_out_bloc.dart';
import '../src/features/auth/presentation/blocs/sign_out/sign_out_event.dart';
import '../src/features/auth/presentation/blocs/sign_out/sign_out_state.dart';
class HodDrawer extends StatelessWidget {
  final String userName;

  const HodDrawer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocListener<SignOutBloc, SignOutState>(
        listener: (context, state) {
          if (state is SignOutInProgress) {
            // Show loading indicator
            const CircularProgressIndicator();
          } else if (state is SignOutSuccess) {
            // Navigate to login page
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
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
                  Text(userName),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.space_dashboard),
              title: const Text("Space"),
              splashColor: Colors.grey[150],
              onTap: () {
                final currentRoute =
                    ModalRoute.of(context)?.settings.name;

                if (currentRoute == "/hod_space_page") {
                  Navigator.pop(context);
                } else {
                  Navigator.popUntil(
                      context, ModalRoute.withName("/hod_space_page"));
                }
              },
            ),
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
                      title: const Text('Confirm Logout',
                          style: TextStyle(color: Colors.black)),
                      content: const Text('Are you sure you want to logout?'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Logout',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            BlocProvider.of<SignOutBloc>(context)
                                .add(SignOutRequested());
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
