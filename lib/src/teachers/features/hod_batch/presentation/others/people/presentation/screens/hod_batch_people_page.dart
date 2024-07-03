import 'package:flutter/material.dart';

import '../../widgets/section_tile.dart';


class HodBatchPeoplePage extends StatelessWidget {
  final String batchId;
  const HodBatchPeoplePage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTile(
          title: "Sec - 1",
          onTap: () {
            Navigator.pushNamed(context, "/hod_batch_people_section");
          },
        ),
        SectionTile(
            title: "Sec - 2",
            onTap: () {
              Navigator.pushNamed(context, "/hod_batch_people_section");
            }),
      ],
    );
  }
}
