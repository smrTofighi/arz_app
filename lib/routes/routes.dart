import 'package:get/get.dart';
import '../screens/home_screen.dart';

class Routes {
  static List<GetPage> get pages => [
        GetPage(
          name: '/homeScreen',
          page: () => HomeScreen(),
        ),
      ];
}