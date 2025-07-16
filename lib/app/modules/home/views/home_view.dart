import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_values.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppValues.largePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileSection(),
          SizedBox(height: 40),
          _buildNameSection(),
          SizedBox(height: 20),
          _buildTitleSection(),
          SizedBox(height: 30),
          _buildDescriptionSection(),
          // SizedBox(height: 50),
          // _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return AnimatedBuilder(
      animation: controller.scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.scaleAnimation.value,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(Icons.person, size: 80, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildNameSection() {
    return AnimatedBuilder(
      animation: controller.fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.fadeAnimation.value,
          child: Text(
            'John Doe',
            style: Get.textTheme.headlineLarge?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
    return SlideTransition(
      position: controller.slideAnimation,
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            'Flutter Developer',
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            speed: Duration(milliseconds: 100),
          ),
          TyperAnimatedText(
            'Mobile App Developer',
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
            speed: Duration(milliseconds: 100),
          ),
          TyperAnimatedText(
            'UI/UX Designer',
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.accent,
            ),
            speed: Duration(milliseconds: 100),
          ),
        ],
        isRepeatingAnimation: true,
        pause: Duration(milliseconds: 2000),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return AnimatedBuilder(
      animation: controller.fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.fadeAnimation.value,
          child: Text(
            'Passionate about creating beautiful\nand functional mobile applications\nwith clean code and great user experience',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        );
      },
    );
  }

  // Widget _buildActionButton() {
  //   return AnimatedBuilder(
  //     animation: controller.fadeAnimation,
  //     builder: (context, child) {
  //       return Opacity(
  //         opacity: controller.fadeAnimation.value,
  //         child: AnimatedButton(
  //           text: 'Get Started',
  //           onPressed: controller.onGetStartedPressed,
  //           gradient: AppColors.primaryGradient,
  //         ),
  //       );
  //     },
  //   );
  // }
}
