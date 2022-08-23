import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:wits_app/view/common_widgets/test_text.dart';
import 'package:timelines/timelines.dart';
import '../../../helper/app_constant.dart';

class TimeLineWidget extends StatefulWidget {
  @override
  _TimeLineWidgetState createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    AppConstant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [Text('asdasd')],
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: const [
                Text('GO'),
                SizedBox(
                  height: 100,
                ),
                Text('1'),
                SizedBox(
                  height: 100,
                ),
                Text('1'),
                SizedBox(
                  height: 100,
                ),
                Text('1'),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Container(
                  width: 200,
                  height: 500,
                  child: Timeline.tileBuilder(
                    builder: TimelineTileBuilder.fromStyle(
                      contentsAlign: ContentsAlign.basic,
                      connectorStyle: ConnectorStyle.dashedLine,
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Timeline Event $index'),
                      ),
                      itemCount: 5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
