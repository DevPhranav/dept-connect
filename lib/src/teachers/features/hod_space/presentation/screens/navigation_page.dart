import 'package:flutter/material.dart';

import '../../../../../authentication/auth/data/models/auth_user_model.dart';
import '../../../../../parents/parent_stream/presentation/screens/parent_batch_stream_page.dart';


class NavigationScreen extends StatelessWidget {

  final AuthUserModel? user;

  const NavigationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user!.userType == 'Teacher') {
        Navigator.pushReplacementNamed(context, '/hod_space');
      }
      if(user!.userType== 'Student')
        {
          Navigator.pushReplacementNamed(context, '/student_space');
        }
      if(user!.userType == "Parent")
        {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ParentBatchStreamPage(batchId: user?.batchId?? "",user: user),
          ));
        }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color:Colors.black),
      ),
    );
  }
}