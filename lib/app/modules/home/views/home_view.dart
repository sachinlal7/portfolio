import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/widgets/navBar.dart';

import '../../../core/utils/responsive.dart';
import '../../../widgets/about_section.dart';
import '../../../widgets/contact_section.dart';
import '../../../widgets/footer_section.dart';
import '../../../widgets/hero_section.dart';
import '../../../widgets/skills_section.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize Responsive class FIRST
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDark,
              AppColors.background,
              AppColors.secondaryDark,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              // Fixed Navigation Bar
              NavBar(),

              // Hero Section
              HeroSection(),

              // About Section
              AboutSection(),

              // Skills Section
              SkillsSection(),

              // // Experience Section
              // ExperienceSection(),
              //
              // // Projects Section
              // ProjectsSection(),

              // Contact Section
              ContactSection(),

              // Footer
              FooterSection(),
            ],
          ),
        ),
      ),
      // Floating Action Button for scroll to top
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: controller.showScrollToTop.value ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: controller.scrollToTop,
            backgroundColor: AppColors.accent,
            child: Icon(Icons.keyboard_arrow_up, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
