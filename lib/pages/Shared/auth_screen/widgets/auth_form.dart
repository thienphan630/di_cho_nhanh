// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/functions/auth_func.dart';
import 'package:di_cho_nhanh/functions/snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/route_path.dart';
import '../../../../constraints/constraints.dart';
import '../../../../models/agruments/auth_agrument.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../utilities/get_user_id.dart';
import 'input.dart';

class FormAuth extends StatefulWidget {
  const FormAuth({
    Key? key,
    required this.authentication,
  }) : super(key: key);
  final AuthAgrument authentication;
  @override
  State<FormAuth> createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isShowed = false;

  Timer _timer = Timer.periodic(const Duration(), (timer) {});
  int _start = 60;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColor.kSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
              child: Column(
            children: [
              Input(
                title: 'Số điện thoại',
                controller: phoneController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      if (widget.authentication.authType == AuthType.login) {
                        _checkPhoneNumberExist(phoneController.text);
                      } else {
                        _verifyPhone();
                        setState(() {
                          isShowed = true;
                        });
                      }
                    },
                    child: const Text('Lấy mã xác nhận')),
              ),
              const SizedBox(height: kDefaultPadding),
              isShowed
                  ? otpForm(context, phoneController.text, otpController)
                  : const SizedBox(),
            ],
          )),
        ),
      ),
    );
  }

  void _checkPhoneNumberExist(String phoneNumber) {
    String collection =
        widget.authentication.role == Role.buyer ? 'users' : 'sellers';

    FirebaseFirestore.instance
        .collection(collection)
        .where('phoneNumber', isEqualTo: '+84$phoneNumber')
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        snackbarMessage(
            context: context,
            message:
                'Số điện thoại này chưa được đăng ký!\nVui lòng quay lại trang trước để đăng ký!');
      } else {
        _verifyPhone();
        setState(() {
          isShowed = true;
        });
      }
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _verifyPhone() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: '+84${phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        log('$credential');
      },
      verificationFailed: (FirebaseAuthException e) {
        snackbarMessage(
            context: context,
            message: 'Số điện thoại không hợp lệ!\nVui lòng nhập lại!');
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
        startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) {
          setState(() {
            _verificationCode = verificationId;
          });
        }
      },
    );
  }

  Widget otpForm(
      BuildContext context, String phone, TextEditingController otp) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mã xác nhận',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kDefaultPadding),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          controller: otp,
          cursorHeight: 20,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            hintText: 'OTP',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.green, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.green, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.red, width: 2)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                try {
                  // Create a PhoneAuthCredential with the code
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: _verificationCode!, smsCode: otp.text);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);

                  AuthType authType = widget.authentication.authType;
                  Role role = widget.authentication.role;
                  String userId = getUserId();
                  String collection = role == Role.buyer ? 'users' : 'sellers';

                  Provider.of<AuthProvider>(context, listen: false)
                      .updateRole(role);
                  saveUserToLocal(UserLocalModal(role: role.name, id: userId));

                  snackbarMessage(
                      context: context,
                      message: authType == AuthType.login
                          ? 'Đăng nhập thành công'
                          : 'Đăng ký thành công');
                  FirebaseFirestore.instance.collection(collection).doc(userId);

                  authType == AuthType.login
                      ? role == Role.buyer
                          ? Navigator.pushNamedAndRemoveUntil(
                              context, RoutePath.home, (route) => false)
                          : Navigator.pushNamedAndRemoveUntil(
                              context, RoutePath.home, (route) => false)
                      : role == Role.buyer
                          ? Navigator.pushNamedAndRemoveUntil(
                              context, RoutePath.addUserInfor, (route) => false)
                          : Navigator.pushNamedAndRemoveUntil(context,
                              RoutePath.addSellerInfor, (route) => false);
                } catch (e) {
                  snackbarMessage(context: context, message: 'Lỗi: $e');
                }
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () async {
                if (_start > 0) return;
                await auth.verifyPhoneNumber(
                  phoneNumber: '+84$phone',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) async {
                    setState(() {
                      _verificationCode = verificationId;
                    });
                    _start = 60;
                    startTimer();
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {
                    setState(() {
                      _verificationCode = verificationId;
                    });
                  },
                );
              },
              child: _start == 0
                  ? const Text('Gửi lại mã')
                  : Text('Gửi lại mã sau $_start s'),
            ),
          ],
        )
      ],
    );
  }
}
