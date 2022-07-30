import 'package:arz_app/controllers/theme_controller.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController());
  }

}