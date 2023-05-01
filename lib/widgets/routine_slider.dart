import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/models/muscle.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import '../models/models.dart';

class RoutineSlider extends StatefulWidget {
  const RoutineSlider({super.key, this.title, required this.muscles});
  final String? title;
  final List<Muscle> muscles;

  @override
  State<RoutineSlider> createState() => _RoutineSliderState();
}

class _RoutineSliderState extends State<RoutineSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widget.muscles.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
        width: double.infinity,
        height: 270,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (widget.title == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) {
                final muscle = widget.muscles[index];
                return _MoviePoster(
                  muscle: muscle,
                );
              },
              itemCount: widget.muscles.length,
            ),
          )
        ]));
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({super.key, required this.muscle});
  final Muscle muscle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            //TODO Details
            onTap: () =>
                Navigator.pushNamed(context, "details", arguments: muscle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primary, width: 3),
                    borderRadius: BorderRadius.circular(20)),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: AssetImage("assets/img/${muscle.name}.jpg"),
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            muscle.name.capitalize(),
            maxLines: 2,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
