import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';
import 'package:myartist/app/modules/home/views/home_search_view.dart';
import 'package:myartist/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "MyArtist",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              MoonIcons.notifications_bell_16_regular,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MoonIcons.generic_menu_16_regular,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              color: Colors.black,
              child: buildSearchWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.SIGNUP);
              },
              child: Text("Open Sign Up"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchWidget() {
    return GestureDetector(
      onTap: () => Get.to(HomeSearchScreen(), transition: Transition.upToDown),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Search",
              style: TextStyle(color: Colors.grey),
            ),
            Icon(
              MoonIcons.generic_search_16_regular,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }
}
