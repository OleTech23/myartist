import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';
import 'package:myartist/app/modules/signup/views/authentication_view.dart';
import 'package:myartist/app/routes/app_pages.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();

    return Obx(() {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/img/signup-artist-bg.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildHeader(context),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create your\nFree Account now!",
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                          const SizedBox(height: 20),
                          AccountButtonSwitcher(
                            onTap: () => controller
                                .selectOption(SignupOptionsEnum.customer),
                            title: "I'm a customer",
                            icon: Icons.favorite,
                            selected: controller
                                .isOptionSelected(SignupOptionsEnum.customer),
                          ),
                          const SizedBox(height: 20),
                          AccountButtonSwitcher(
                            onTap: () => controller
                                .selectOption(SignupOptionsEnum.artist),
                            title: "I'm a tattoo artist",
                            icon: Icons.auto_awesome,
                            selected: controller
                                .isOptionSelected(SignupOptionsEnum.artist),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MoonButton(
                            onTap: () => Get.to(
                              SignupAuthenticationView(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                            isFullWidth: true,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            label: const Text("Continue"),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed(Routes.LOGIN),
                          child: const Text(
                            "Already have an account? Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  buildSignUp(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up with Phone",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          // Handle country code selection
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/img/flag.png', // Replace with actual flag image
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "+1", // Replace with actual country code
                                style: TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle continue action
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Center(child: Text("Continue")),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.grey),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Handle email sign in option
                    },
                    child: Text(
                      "Sign up with Email",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Column buildHeader(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "English",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: const Text(
          'My Artist',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

class AccountButtonSwitcher extends StatelessWidget {
  const AccountButtonSwitcher({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: !selected ? Colors.white : Colors.black,
              ),
              Text(
                title,
                style: TextStyle(
                    color: !selected ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Visibility.maintain(
                visible: selected,
                child: Icon(Icons.check_circle),
              )
            ],
          ),
        ),
      ),
    );
  }
}
