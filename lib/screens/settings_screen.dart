import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/auth.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return const Scaffold(
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

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SettingsCard(
        text: "Account",
        iconData: Icons.account_circle_outlined,
      ),
      const Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, "favorites"),
        child: const SettingsCard(
          text: "Favorite exercises",
          iconData: Icons.star_outline,
        ),
      ),
      const Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      const SettingsCard(
        text: "Language",
        iconData: Icons.language_outlined,
      ),
      const Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      const SettingsCard(
        text: "Security",
        iconData: Icons.verified_user_outlined,
      ),
      const Divider(
        thickness: 1,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      const SettingsCard(
        text: "About",
        iconData: Icons.help_outline_outlined,
      ),
      const Divider(
        thickness: 0,
        height: 1,
        indent: 30,
        endIndent: 30,
      ),
      GestureDetector(
        onTap: () => signOut(),
        child: Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromRGBO(190, 32, 42, 1),
          child: const Center(
            child: Text(
              "Sign out",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      )
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
      color: Colors.transparent,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
    final user = FirebaseAuth.instance.currentUser;
    final userName = user != null ? user.displayName ?? "Usuario" : "Usuario";
    return Container(
      padding: const EdgeInsets.all(10),
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
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
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
              child: Text(
                userName.toString(),
                style: const TextStyle(
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
