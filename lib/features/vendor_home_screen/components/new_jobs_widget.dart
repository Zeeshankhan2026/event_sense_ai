import 'package:flutter/material.dart';

class NewJobsWidget extends StatelessWidget {
  final String tag;
  final String title;
  final String dateTime;
  final String location;
  final String budget;
  final String imagePath;


  const NewJobsWidget({super.key,
    required this.tag,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.budget,
    required this.imagePath,

  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
