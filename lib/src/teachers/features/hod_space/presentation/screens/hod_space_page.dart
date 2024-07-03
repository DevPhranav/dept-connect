import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../static/hod_drawer.dart';
import '../../../auth/data/models/auth_user_model.dart';
import '../../../batch_creation/presentation/bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_bloc.dart';
import '../../../batch_creation/presentation/bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_event.dart';
import '../../../batch_creation/presentation/bloc/batch_year_bloc/batch_year_bloc.dart';
import '../../../batch_creation/presentation/bloc/batch_year_bloc/batch_year_event.dart';
import '../../../batch_creation/presentation/bloc/file_pick_bloc/file_pick_bloc.dart';
import '../../../batch_creation/presentation/bloc/file_pick_bloc/file_pick_event.dart';
import '../../../hod_batch/presentation/others/stream/stream_main/presentation/bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
import '../blocs/hod_space/hod_batch_bloc.dart';
import '../widgets/batch_tile.dart';

class HodSpacePage extends StatefulWidget {
  final AuthUserModel? user;

  const HodSpacePage({super.key, required this.user});

  @override
  HodSpacePageState createState() => HodSpacePageState();
}

class HodSpacePageState extends State<HodSpacePage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to load batches
    context.read<HodBatchBloc>().add(HodBatchLoadRequestedEvent(widget.user!.department ?? "CSE"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space"),
        centerTitle: true,
      ),
      drawer: HodDrawer(userName: widget.user?.name ?? 'No user name'),
      body: BlocBuilder<HodBatchBloc, HodBatchState>(
        builder: (context, state) {
          if (state is HodBatchLoading) {
            return const Center(
              child: CircularProgressIndicator(color:Colors.black),
            );
          } else if (state is HodBatchLoaded) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return BatchTile(
                        title: state.batchIds[index],
                        batchYear: state.batchIds[index],
                        onTap: () {
                          final batchId = state.batchIds[index];
                          print(batchId);
                          // Handle the tap event for batch tile
                          context.read<MessageBloc>().setBatchId(batchId);
                          Navigator.pushNamed(
                            context,
                            "/hod_batch_page",
                            arguments: {
                              'user': widget.user,
                              'batchId': batchId,
                            },
                          );
                        },
                      );
                    },
                    childCount: state.batchIds.length,
                  ),
                ),
              ],
            );
          } else if (state is HodBatchError) {
            return Center(
              child: Text("Error: ${state.errorMessage}"),
            );
          } else {
            return const Center(
              child: Text("No batches found"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<BatchYearBloc>(context).add(BatchYearInitialEvent());
          BlocProvider.of<DropdownBloc>(context).add(DropDownInitialEvent());
          BlocProvider.of<BatchCreationFilePickerBloc>(context).add(FilePickInitialEvent());
          Navigator.pushNamed(context, "/hod_batch_creation_page");
        },
        backgroundColor: Colors.grey[50],
        elevation: 3,
        child: const Icon(Icons.add),
      ),
    );
  }
}
