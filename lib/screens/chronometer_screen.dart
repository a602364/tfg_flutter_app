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
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

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

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;

      laps.clear();
    });
  }

  void setLap() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  void dispose() {
    // Cancelar el temporizador en el método dispose
    timer?.cancel();
    super.dispose();
  }

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$digitHours:$digitMinutes:$digitSeconds",
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
                child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? reset() : setLap();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: Colors.transparent),
                        color: AppTheme.secondary),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 20,
                      child: Text(
                        (!started) ? "Reset" : "Lap",
                        style: const TextStyle(color: Colors.black),
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
                child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? start() : stop();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.transparent),
                        color: (!started)
                            ? AppTheme.primary
                            : const Color.fromRGBO(190, 32, 42, 1)),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 20,
                      child: Text(
                        (!started) ? "Start" : "Stop",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}

class LapViewer extends StatelessWidget {
  const LapViewer({
    Key? key,
    required this.laps,
  }) : super(key: key);

  final List laps;

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
          itemBuilder: ((context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lap nº${index + 1}",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "${laps[index]}",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
            );
          }),
          itemCount: laps.length,
        ),
      ),
    );
  }
}
