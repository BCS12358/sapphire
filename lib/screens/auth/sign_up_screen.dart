import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sapphire/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback toggleView;

  const SignUpScreen({super.key, required this.toggleView});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text('Sign in'))
      ]),
      body: Column(
        children: [
          Lottie.asset('assets/images/calendar.json', width: 179),
          Text(
            'Yet another todo list',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Enter email'),
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value == null || !value.contains('@')
                                ? 'Enter email adress'
                                : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'Enter password'),
                        obscureText: true,
                        validator: (value) => value!.length < 6
                            ? 'Enter a password of at least 6 chars'
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final user = await AuthService()
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                            print(user);
                          }
                        },
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
