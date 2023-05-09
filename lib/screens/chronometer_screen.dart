import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';

class ChronometerScreen extends StatelessWidget {
  const ChronometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Chronometer());
  }
}

class Chronometer extends StatefulWidget {
  const Chronometer({
    Key? key,
  }) : super(key: key);

  @override
  State<Chronometer> createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {
  Timer? timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  List<String> laps = [];
  bool started = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
        if (seconds >= 60) {
          seconds = 0;
          minutes++;
          if (minutes >= 60) {
            minutes = 0;
            hours++;
          }
        }
      });
    });
    setState(() {
      started = true;
    });
  }

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      laps.clear();
      started = false;
    });
  }

  void setLap() {
    final lap = '$hours:${_formatTime(minutes)}:${_formatTime(seconds)}';
    setState(() {
      laps.add(lap);
    });
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final digitSeconds = _formatTime(seconds);
    final digitMinutes = _formatTime(minutes);
    final digitHours = _formatTime(hours);

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(
            '$digitHours:$digitMinutes:$digitSeconds',
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LapViewer(laps: laps),
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Expanded(
                    child: MaterialButton(
                      padding: const EdgeInsets.all(3),
                      animationDuration: const Duration(milliseconds: 100),
                      onPressed: started ? setLap : reset,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 3,
                            color: Colors.transparent,
                          ),
                          color: AppTheme.secondary,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          width: 50,
                          height: 20,
                          child: Text(
                            started ? 'Lap' : 'Reset',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Expanded(
                    child: MaterialButton(
                      animationDuration: const Duration(milliseconds: 100),
                      padding: const EdgeInsets.all(3),
                      onPressed: started ? stop : start,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          color: started
                              ? const Color.fromRGBO(190, 32, 42, 1)
                              : AppTheme.primary,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          width: 50,
                          height: 20,
                          child: Text(
                            started ? 'Stop' : 'Start',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

class LapViewer extends StatelessWidget {
  const LapViewer({
    Key? key,
    required this.laps,
  }) : super(key: key);

  final List<String> laps;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.secondary,
      child: SizedBox(
        height: 300,
        width: 300,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lap nº${index + 1}',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      laps[index],
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: laps.length,
        ),
      ),
    );
  }
}
