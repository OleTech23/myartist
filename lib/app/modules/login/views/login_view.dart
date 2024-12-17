import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myartist/app/modules/widgets/authentication_form.dart';
import 'package:myartist/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
            child: AuthenticationForm(
              onComplete: (user, error) {
                if (user != null && error == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.HOME,
                    (route) => false,
                  );
                }
              },
              hasSignupMode: false,
            ),
          )
        ],
      ),
    );
  }
}
