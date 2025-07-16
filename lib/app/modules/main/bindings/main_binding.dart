import 'package:get/get.dart';
import 'package:portfolio/app/modules/about/controllers/about_controller.dart';
import 'package:portfolio/app/modules/contact/controllers/contact_controller.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/app/modules/projects/controllers/projects_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<ProjectsController>(() => ProjectsController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
