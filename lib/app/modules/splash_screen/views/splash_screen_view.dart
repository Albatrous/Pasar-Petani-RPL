import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasar_petani/config/constants.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        initState: controller.redirect(),
        builder: (
          context,
        ) {
          return Scaffold(
            body: Center(
              child: logo,
            ),
          );
        });
  }
}
