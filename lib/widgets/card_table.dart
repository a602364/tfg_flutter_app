import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardTable extends StatelessWidget {
  const CardTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(children: [
          _SingleCard(
              color: Colors.black,
              icon: FontAwesomeIcons.addressBook,
              text: "45° side bend"),
          _SingleCard(
              color: Colors.black,
              icon: Icons.fitness_center,
              text: "all fours squad stretch"),
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  const _SingleCard({
    Key? key,
    required this.color,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final Color color;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _SingleCardBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 35,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text.capitalize(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              color: color,
              fontSize: 16,
            )),
          ),
        ),
      ],
    ));
  }
}

class _SingleCardBackground extends StatelessWidget {
  const _SingleCardBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 175,
          decoration: BoxDecoration(
              color: AppTheme.secondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: AppTheme.primary)),
          child: child,
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
