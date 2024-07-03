import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../static/hod_drawer.dart';
import '../../../auth/data/models/auth_user_model.dart';
import '../bloc/navigation/hod_navigation_bloc.dart';
import '../bloc/navigation/hod_navigation_event.dart';
import '../bloc/navigation/hod_navigation_state.dart';
import '../others/course/presentation/pages/semester_list_page.dart';
import '../others/people/presentation/screens/hod_batch_people_page.dart';
import '../others/stream/stream_main/presentation/bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
import '../others/stream/stream_main/presentation/bloc/stream_page_blocs/message_show_bloc/message_show_event.dart';
import '../others/stream/stream_main/presentation/screens/hod_stream_page.dart';


class HodBatchPage extends StatelessWidget {
  final AuthUserModel? user;
  final String batchId;
  const HodBatchPage({super.key, required this.user, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(''),
      ),
      drawer: HodDrawer(userName: user!.name ?? "no user ",),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          BlocProvider.of<MessageBloc>(context).add(LoadMessagesEvent(batchId: batchId));
          final List<Widget> hodBatchPages = [
            HodBatchStreamPage(batchId: batchId),
            SemesterListView(batchId: batchId),
            HodBatchPeoplePage(batchId: batchId),
          ];
          return hodBatchPages[state.selectedIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.read<NavigationBloc>().add(const NavigationEventStream());
                  break;
                case 1:
                  context.read<NavigationBloc>().add(const NavigationEventCourse());
                  break;
                case 2:
                  context.read<NavigationBloc>().add(const NavigationEventPeople());
                  break;
              }
            },
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.message), label: "Stream"),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "Course"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
            ],
          );
        },
      ),
    );
  }
}
