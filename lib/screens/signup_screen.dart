import 'package:fennechms/providers/auth.dart';
import 'package:fennechms/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = 'signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'An Error Occured',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              content: Text(
                message,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ],
            ));
  }

  _signup() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Missing Fields', context);
      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Password did not Match', context);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(_emailController.text, _passwordController.text);
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed!';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This email is invalid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is weak';
      }
      _showErrorDialog(errorMessage, context);
    } catch (error) {
      const errorMessage =
          'Could not Autahenticate you, Please try again later!';
      _showErrorDialog(errorMessage, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Signup'))),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              width: double.infinity,
              height: 250,
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            const SizedBox(
              height: 30,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: const Size(120, 40),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white),
                    child: const Text('Login'),
                    onPressed: _signup,
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Already have an Account?',
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
