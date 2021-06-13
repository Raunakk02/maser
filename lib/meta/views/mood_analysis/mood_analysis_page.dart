import 'package:flutter/material.dart';
import 'package:maser/meta/widgets/custom_app_bar.dart';

class MoodAnalysisPage extends StatelessWidget {
  const MoodAnalysisPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Mood Analysis'),
      body: Center(
        //TODO: implement tensorflow model
        child: Text('Need camera module'),
      ),
    );
  }
}
