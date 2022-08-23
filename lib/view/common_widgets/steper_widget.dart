import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

class IconStepperDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steps Indicator Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Steps Indicator Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedStep = 2;
  int nbSteps = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StepsIndicator(
            selectedStep: selectedStep,
            nbSteps: nbSteps,
            doneLineColor: Colors.green,
            doneStepColor: Colors.green,
            undoneLineColor: Colors.red,
            undoneLineThickness: .5,
            isHorizontal: false,
            lineLength: 20,
            lineLengthCustomStep: [
              StepsIndicatorCustomLine(
                nbStep: 1,
                length: 40,
              )
            ],
            enableLineAnimation: true,
            enableStepAnimation: true,
          ),
        ],
      )),
    );
  }
}
