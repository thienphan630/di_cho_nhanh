import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../constraints/index.dart';
import 'input.dart';

class FormAuth extends StatefulWidget {
  const FormAuth({
    Key? key,
    required this.isSignUp,
  }) : super(key: key);
  final bool isSignUp;
  @override
  State<FormAuth> createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  bool _isCheck = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
            child: Column(
          children: [
            const Input(
              title: 'Your Email',
              hint: 'someone@example.com',
              obscureText: false,
            ),
            const SizedBox(height: 24),
            const Input(
              title: 'Password',
              hint: '••••••••••••',
              obscureText: true,
            ),
            !widget.isSignUp
                ? Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text('Forget Password?')),
                  )
                : const SizedBox(height: 24),
            Button(
              text: widget.isSignUp ? 'Create account' : 'Log In',
              width: size.width,
              color: kPrimaryColor,
              onPress: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (_isCheck) {
                  log('true');
                } else {
                  log('false');
                }
              },
            ),
            widget.isSignUp ? checkCondication() : const SizedBox(height: 12),
            _alreadyHaveAnAccount(context, widget.isSignUp),
            //TODO: login with google/facebook
          ],
        )),
      ),
    );
  }

  Widget checkCondication() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        children: [
          Checkbox(
              value: _isCheck,
              onChanged: (value) {
                setState(() {
                  _isCheck = !_isCheck;
                });
              }),
          const Flexible(
            child: Text(
              'By creating an account you have to agree with our them & condication.',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: kSecondaryTextColor),
            ),
          )
        ],
      ),
    );
  }
}

Widget _alreadyHaveAnAccount(context, bool isSignUp) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(isSignUp ? 'Already have an account?' : 'Don\'t have an account?',
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: kSecondaryTextColor)),
      TextButton(
          onPressed: () {
            isSignUp
                ? Navigator.pushReplacementNamed(context, '/login')
                : Navigator.pushReplacementNamed(context, '/signup');
          },
          child: Text(
            isSignUp ? 'Log in' : 'Sign up',
            style: const TextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ))
    ],
  );
}
