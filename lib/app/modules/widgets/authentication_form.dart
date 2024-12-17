import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moon_design/moon_design.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm(
      {super.key, required this.onComplete, required this.hasSignupMode});

  final bool hasSignupMode;
  final Function(User? user, String? error) onComplete;

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      FocusScope.of(context).unfocus();

      await EasyLoading.show();

      if (widget.hasSignupMode) {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }

      await EasyLoading.dismiss();

      final user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        await buildEmailVerificationDialog(user);
      } else {
        widget.onComplete(user, null);
      }
    } catch (e) {
      EasyLoading.dismiss();
      debugPrint("Auth - Email Err:$e");
      debugPrint("Auth Err Code: ${(e as dynamic).code}");

      if ((e as dynamic).code == "email-already-in-use" &&
          _auth.currentUser != null &&
          _auth.currentUser?.emailVerified != true) {
        final user = _auth.currentUser;
        await user?.sendEmailVerification();
        await buildEmailVerificationDialog(user!);
      }

      widget.onComplete(
        null,
        (e as FirebaseAuthException).message ?? "Something went wrong",
      );
    }
  }

  Future<dynamic> buildEmailVerificationDialog(User user) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Verification'),
          content: Text(
              'A verification email has been sent to ${user.email}. Please verify your email to continue.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                await EasyLoading.show(status: 'Checking verification...');
                while (true) {
                  await Future.delayed(Duration(seconds: 3));
                  final user = _auth.currentUser;
                  await user?.reload();
                  if (user != null && user.emailVerified) {
                    await EasyLoading.dismiss();
                    widget.onComplete(user, null);
                    break;
                  }
                }

                widget.onComplete(user, null);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _signInWithGoogle() async {
    // return _signOutGoogle();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await EasyLoading.show();
      await _auth.signInWithCredential(credential);
      await EasyLoading.dismiss();
      // Collect first and last name
      final user = _auth.currentUser;

      widget.onComplete(user, null);
    } catch (e) {
      await _signOutGoogle();
      EasyLoading.dismiss();
      debugPrint("Auth - Google Err: $e");
      widget.onComplete(
        null,
        (e as FirebaseAuthException).message ?? "Something went wrong",
      );
    }
  }

  Future<void> _signOutGoogle() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  MoonFormTextInput(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  MoonFormTextInput(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  if (widget.hasSignupMode)
                    MoonFormTextInput(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  SizedBox(height: 20),
                  MoonButton(
                    isFullWidth: true,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    },
                    label: Text('Sign ${widget.hasSignupMode ? "Up" : "In"}'),
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            SizedBox(height: 5),
            MoonOutlinedButton(
              isFullWidth: true,
              onTap: _signInWithGoogle,
              label: Text(
                'Sign ${widget.hasSignupMode ? "Up" : "In"} with Google',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(15),
          ],
        ),
      ),
    );
  }
}

class AuthenticationProfileForm extends StatefulWidget {
  const AuthenticationProfileForm({super.key, required this.onComplete});

  final Function(bool done, String? error) onComplete;

  @override
  State<AuthenticationProfileForm> createState() =>
      _AuthenticationProfileFormState();
}

class _AuthenticationProfileFormState extends State<AuthenticationProfileForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  void onSubmit() async {
    try {
      await EasyLoading.show();

      await FirebaseAuth.instance.currentUser?.updateProfile(
        displayName: '${_firstNameController.text} ${_lastNameController.text}',
      );
      widget.onComplete(true, null);
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      widget.onComplete(false, e.message);
    } catch (e) {
      EasyLoading.dismiss();
      widget.onComplete(false, e.toString());
    }
  }

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoonFormTextInput(
                controller: _firstNameController,
                hintText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              const Gap(5),
              MoonFormTextInput(
                controller: _lastNameController,
                hintText: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const Gap(5),
      ],
    );
  }
}
