import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class ChronometerScreen extends StatelessWidget {
  const ChronometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularCountDownTimer(
          duration: 60,
          height: 200,
          fillColor: Colors.red,
          ringColor: Colors.orange,
          width: 200,
        ),
      ),
    );
  }
}
