import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  void toggle() {
    isDark.value = !isDark.value;
  }

  void changeTheme(){
    if(isDark.value == true){
      Get.changeTheme(ThemeData.dark());
    }
    else{
      Get.changeTheme(ThemeData.light());
    }
  }
}
