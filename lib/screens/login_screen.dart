import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/auth.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:tfg_flutter_app/widgets/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final User? user = Auth().currentUser;

  String? errorMessage = "";

  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Future<void> signOut() async {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {
      "email": "",
      "password": "",
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.all(10),
              child: Image.asset("assets/img/logo_outlined.png",
                  scale: 3, fit: BoxFit.fitHeight)),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Welcome back!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
          ),
          const SizedBox(
            height: 5,
          ),
          FormSignIn(
            formValues: formValues,
            controllerEmail: _controllerEmail,
            controllerPassword: _controllerPassword,
          ),
          const SizedBox(
            height: 20,
          ),
          SignInButton(
            onPressed: createUserWithEmailAndPassword,
          ),
          const SizedBox(
            height: 40,
          ),
          const Row(children: <Widget>[
            Expanded(
                child: Divider(
              endIndent: 10,
              indent: 30,
              thickness: 2,
            )),
            Text("Or sign in with"),
            Expanded(
                child: Divider(
              endIndent: 30,
              indent: 10,
              thickness: 2,
            )),
          ]),
        ]),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: const EdgeInsets.all(3),
        animationDuration: const Duration(milliseconds: 100),
        onPressed: onPressed, // Sin los paréntesis aquí
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 3,
              color: Colors.transparent,
            ),
            color: AppTheme.primary,
          ),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            width: 80,
            height: 30,
            child: const Text(
              "Sign in",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}

class FormSignIn extends StatelessWidget {
  const FormSignIn({
    super.key,
    required this.formValues,
    required this.controllerEmail,
    required this.controllerPassword,
  });

  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;

  final Map<String, String> formValues;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          CustomInputField(
            formProperty: "email",
            formValues: formValues,
            labelText: "Email",
            icon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
            hintText: "Enter your email",
            controller: controllerEmail,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomInputField(
            formProperty: "password",
            formValues: formValues,
            labelText: "Password",
            icon: Icons.lock_outline,
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: controllerPassword,
          )
        ]),
      ),
    );
  }
}
