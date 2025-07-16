import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/main/controllers/main_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  final RxBool isAnimating = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.3, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  void _startAnimations() {
    animationController.forward();
  }

  void onGetStartedPressed() {
    Get.find<MainController>().changeTab(1);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
