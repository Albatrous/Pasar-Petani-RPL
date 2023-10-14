import 'dart:async';

import 'package:get/get.dart';
import 'package:pasar_petani/app/routes/app_pages.dart';
import 'package:pasar_petani/config/constants.dart';

class SplashScreenController extends GetxController {
  redirect() => Timer.periodic(const Duration(seconds: 3), (timer) {
        if (storage.read('access_token') != null) {
          Get.offNamed(Routes.HOME);
        } else {
          Get.offNamed(Routes.LOGIN);
        }
        timer.cancel();
      });
}
