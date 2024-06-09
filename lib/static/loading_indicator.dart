import 'package:flutter/material.dart';

class LoaderTransparent extends StatelessWidget {
  final Color colorValue;

  const LoaderTransparent({super.key, required this.colorValue});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Opacity(
      opacity: 0.5,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey,
        child: Center(
          child: SizedBox(
            height: 60.0,
            width: 60.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(colorValue),
              strokeWidth: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
