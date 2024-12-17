import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';
import 'package:myartist/app/modules/signup/controllers/signup_controller.dart';
import 'package:myartist/app/modules/widgets/appbar/series_app_bar.dart';
import 'package:myartist/app/modules/widgets/authentication_form.dart';
import 'package:myartist/app/modules/widgets/painters/user_avatar.dart';

class SignupAuthenticationView extends GetView<SignupController> {
  const SignupAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SeriesAppBar(
          title: "Personal information",
          activeIndex: controller.activeSignupPage.value,
          totalIndex: 2,
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: PageController(),
          children: [
            buildSignupStage(context, () {
              controller.activeSignupPage.value = 2;
              PageController().animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }),
            _buildProfileFormSection(context),
          ],
        ),
      ),
    );
  }

  Column buildSignupStage(BuildContext context, VoidCallback onComplete) {
    return Column(
      children: [
        const Gap(45),
        Expanded(
          child: AuthenticationForm(
            hasSignupMode: true,
            onComplete: (user, error) {
              debugPrint("User $user, Error $error");
              if (error != null) MoonToast.show(context, label: Text(error));
              if (user != null && user.emailVerified) {
                MoonToast.show(
                  context,
                  label: Text("Success"),
                );
                onComplete();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileFormSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: NoUserPainter(),
          ),
          const SizedBox(height: 20), // Replaces `Gap` for better reusability
          Expanded(
            child: AuthenticationProfileForm(
              onComplete: (user, error) {
                // Handle form submission
              },
            ),
          ),
        ],
      ),
    );
  }
}
