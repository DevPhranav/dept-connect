import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(),
    ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
