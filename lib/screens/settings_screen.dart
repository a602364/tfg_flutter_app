import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [UserDataCard(), OptionsContainer()],
      )),
    );
  }
}

class OptionsContainer extends StatelessWidget {
  const OptionsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      SettingsCard(
        text: "Account",
        iconData: Icons.account_circle_outlined,
      ),
      Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      SettingsCard(
        text: "Notifications",
        iconData: Icons.notifications_active_outlined,
      ),
      Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      SettingsCard(
        text: "Language",
        iconData: Icons.language_outlined,
      ),
      Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      SettingsCard(
        text: "Security",
        iconData: Icons.verified_user_outlined,
      ),
      Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      SettingsCard(
        text: "About",
        iconData: Icons.help_outline_outlined,
      ),
    ]);
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.text,
    required this.iconData,
  });

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class UserDataCard extends StatelessWidget {
  const UserDataCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: AppTheme.primary,
          width: 300,
          height: 125,
          child: Row(children: [
            const SizedBox(
              width: 10,
            ),
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.secondary,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsetsDirectional.all(10),
              width: 150,
              height: double.maxFinite,
              child: const Text(
                "Israel Gómez Gámez",
                style: TextStyle(
                    fontSize: 20,
                    color: AppTheme.secondary,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
