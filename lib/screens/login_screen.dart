import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tfg_flutter_app/auth.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:tfg_flutter_app/widgets/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final User? user = Auth().currentUser;

  String? errorMessage = "";

  bool isLogin = false;

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

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<void> signOut() async {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          Text(
            isLogin ? "Welcome back!" : "Welcome!",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: MaterialButton(
              padding: const EdgeInsets.all(3),
              animationDuration: const Duration(milliseconds: 100),
              onPressed: isLogin
                  ? signInWithEmailAndPassword
                  : createUserWithEmailAndPassword, // Sin los paréntesis aquí
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                  child: Text(
                    isLogin ? "Login" : "Register",
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin ? 'Register instead' : 'Login instead',
                style: const TextStyle(
                    color: AppTheme.primary, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            const Expanded(
                child: Divider(
              endIndent: 10,
              indent: 50,
              thickness: 2,
            )),
            Text(isLogin ? 'Or register with' : 'Or sign in with'),
            const Expanded(
                child: Divider(
              endIndent: 50,
              indent: 10,
              thickness: 2,
            )),
          ]),
          const SizedBox(
            height: 20,
          ),
          SignInButton(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            Buttons.Google,
            elevation: 0.5,
            text: "Sign up with Google",
            onPressed: () => signInWithGoogle(),
          ),
        ]),
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
