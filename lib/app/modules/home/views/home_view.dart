import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myartist/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.SIGNUP);
            },
            child: Text("Open Sign Up"),
          )
        ],
      ),
    );
  }
}
