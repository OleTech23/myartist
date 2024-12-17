import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthenticationService extends GetxController {
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() async {
    super.onReady();

    debugPrint("On ready called!");

    await Future.delayed(Duration(seconds: 5));
    buildAccountCheck();
  }

  void buildAccountCheck() async {
    var user = _auth.currentUser;

    debugPrint("Check: $user");

    if (user != null && !user.emailVerified) {
      showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verify your account'),
            content:
                Text('Please verify your email to continue using the app.'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: Text('Resend Email'),
                onPressed: () async {
                  await EasyLoading.show(status: 'Checking verification...');
                  await user.sendEmailVerification();

                  while (true) {
                    await Future.delayed(Duration(seconds: 3));
                    await user.reload();
                    if (user.emailVerified) {
                      await EasyLoading.dismiss();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      break;
                    }
                  }
                },
              ),
            ],
          );
        },
      ).then((_) {
        if (!user.emailVerified) SystemNavigator.pop();
      });
    }
  }
}
