import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SanadApp',
          style: TextStyle(fontSize: 72),
        ),
      ),
    );
  }
}
