import 'package:flutter/material.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/people/presentation/screens/section_page.dart';

import '../../widgets/section_tile.dart';

class HodBatchPeoplePage extends StatelessWidget {
  final String batchId;
  const HodBatchPeoplePage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SectionTile(
            title: "Sec - 1",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionPage(batchId: batchId, section: "1"),
                ),
              );
            },
          ),
          SectionTile(
            title: "Sec - 2",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionPage(batchId: batchId, section: "2"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
