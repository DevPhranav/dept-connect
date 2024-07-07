import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/students/home_page/presentation/screens/student_space_page.dart';

import '../src/authentication/auth/data/models/auth_user_model.dart';
import '../src/authentication/auth/presentation/blocs/sign_out/sign_out_bloc.dart';
import '../src/authentication/auth/presentation/blocs/sign_out/sign_out_event.dart';
import '../src/authentication/auth/presentation/blocs/sign_out/sign_out_state.dart';
import '../src/teachers/announcements/presentation/blocs/communication_announcement_blocs/faculty_message_show_bloc/faculty_message_bloc.dart';
import '../src/teachers/announcements/presentation/blocs/communication_announcement_blocs/faculty_message_show_bloc/faculty_message_event.dart';
import '../src/teachers/announcements/presentation/screens/communication_announcement_page.dart';
import '../src/teachers/features/hod_space/presentation/screens/hod_space_page.dart';

class DeptDrawer extends StatelessWidget {
  final AuthUserModel? user;
  final String? batchId;

  const DeptDrawer({super.key, required this.user, required this.batchId});



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
            if (user?.userType == "Teacher")
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HodSpacePage(user: user)),
                            (route) => false,
                      );
                    }
                  }
                },
              ),

            if (user?.userType != "Student" && user?.role == "HOD")
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text("Requests"),
                onTap: () {},
              ),

            if (user?.role != "HOD")
              ListTile(
                leading: const Icon(Icons.announcement),
                title: const Text("Announcements"),
                onTap: () {
                  if (user?.userType == "Student" || user?.userType == "Parent") {
                      Navigator.pop(context);
                  }
                  if(user?.userType == "Teacher")
                    {
                      context.read<FacultyMessageBloc>().facultySetBatchId(user);
                      BlocProvider.of<FacultyMessageBloc>(context).add(FacultyLoadMessagesEvent( user: user));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommunicationAnnouncementStreamPage(
                            user: user,
                          ),
                        ),
                      );
                    }
                },
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
