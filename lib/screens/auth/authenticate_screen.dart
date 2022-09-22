import 'package:flutter/material.dart';
import 'package:sapphire/screens/auth/sign_in_screen.dart';
import 'package:sapphire/screens/auth/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignInScreen = true;

  void toogleView() {
    setState(() {
      _showSignInScreen = !_showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showSignInScreen
          ? SignInScreen(toggleView: toogleView)
          : SignUpScreen(toggleView: toogleView),
    );
  }
}
