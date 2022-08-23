import 'package:flutter/material.dart';
import 'package:wits_app/helper/app_fonts.dart';

class TestWid extends StatelessWidget {
  const TestWid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: Center(
          child: Text(
        'احب نفسك اولا',
        style: TextStyle(fontSize: AppFonts.getXXXXXLargeFontSize(context)),
      )),
    );
  }
}
