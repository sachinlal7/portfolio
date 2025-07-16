import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_strings.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/app/widgets/animated_button.dart';
import 'package:portfolio/app/widgets/social_links.dart';

class HeroSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.heroKey,
      height: Responsive.screenHeight * 0.9,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop ? 80 : 20,
                vertical: 40,
              ),
              child: Responsive.isDesktop
                  ? _buildDesktopLayout()
                  : _buildMobileLayout(),
            ),
          ),
          _buildScrollIndicator(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildTextContent()),
        SizedBox(width: 80),
        Expanded(flex: 2, child: _buildProfileImage()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(),
        SizedBox(height: 40),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: Responsive.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: controller.heroAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.heroAnimationController.value),
              ),
              child: Opacity(
                opacity: controller.heroAnimationController.value,
                child: Text(
                  AppStrings.greeting,
                  style: TextStyle(
                    fontSize: Responsive.isDesktop ? 24 : 18,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 10),
        AnimatedBuilder(
          animation: controller.heroAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.heroAnimationController.value),
              ),
              child: Opacity(
                opacity: controller.heroAnimationController.value,
                child: Text(
                  AppStrings.name,
                  style: TextStyle(
                    fontSize: Responsive.isDesktop ? 72 : 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Container(
          height: 80,
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Flutter Developer',
                textStyle: TextStyle(
                  fontSize: Responsive.isDesktop ? 36 : 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                speed: Duration(milliseconds: 100),
              ),
              TyperAnimatedText(
                'Mobile App Developer',
                textStyle: TextStyle(
                  fontSize: Responsive.isDesktop ? 36 : 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
                speed: Duration(milliseconds: 100),
              ),
              TyperAnimatedText(
                'Full Stack Developer',
                textStyle: TextStyle(
                  fontSize: Responsive.isDesktop ? 36 : 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
                speed: Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: Duration(milliseconds: 2000),
          ),
        ),
        SizedBox(height: 30),
        AnimatedBuilder(
          animation: controller.heroAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.heroAnimationController.value),
              ),
              child: Opacity(
                opacity: controller.heroAnimationController.value,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.isDesktop ? 600 : double.infinity,
                  ),
                  child: Text(
                    AppStrings.heroDescription,
                    style: TextStyle(
                      fontSize: Responsive.isDesktop ? 18 : 16,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    textAlign: Responsive.isDesktop
                        ? TextAlign.left
                        : TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40),
        AnimatedBuilder(
          animation: controller.heroAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.heroAnimationController.value),
              ),
              child: Opacity(
                opacity: controller.heroAnimationController.value,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: Responsive.isDesktop
                      ? WrapAlignment.start
                      : WrapAlignment.center,
                  children: [
                    AnimatedButton(
                      text: 'View My Work',
                      onPressed: () =>
                          controller.scrollToSection(controller.projectsKey),
                      isPrimary: true,
                    ),
                    AnimatedButton(
                      text: 'Download Resume',
                      onPressed: controller.downloadResume,
                      isPrimary: false,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40),
        AnimatedBuilder(
          animation: controller.heroAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.heroAnimationController.value),
              ),
              child: Opacity(
                opacity: controller.heroAnimationController.value,
                child: SocialLinks(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return AnimatedBuilder(
      animation: controller.heroAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * controller.heroAnimationController.value),
          child: Container(
            width: Responsive.isDesktop ? 400 : 280,
            height: Responsive.isDesktop ? 400 : 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  AppColors.accent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 3,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScrollIndicator() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: controller.heroAnimationController,
        builder: (context, child) {
          return Opacity(
            opacity: controller.heroAnimationController.value,
            child: Column(
              children: [
                Text(
                  'Scroll Down',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 2),
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, 10 * value),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.accent,
                        size: 24,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
