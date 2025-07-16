import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_values.dart';
import 'package:portfolio/app/modules/about/views/about_view.dart';
import 'package:portfolio/app/modules/contact/views/contact_view.dart';
import 'package:portfolio/app/modules/home/views/home_view.dart';
import 'package:portfolio/app/modules/projects/views/projects_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    HomeView(),
                    AboutView(),
                    ProjectsView(),
                    ContactView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(AppValues.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => AnimatedSwitcher(
              duration: AppValues.animationDuration,
              child: Text(
                controller.titles[controller.currentIndex.value],
                key: ValueKey(controller.currentIndex.value),
                style: Get.textTheme.headlineMedium,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppValues.radius),
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppValues.largeRadius),
          topRight: Radius.circular(AppValues.largeRadius),
        ),
      ),
      child: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person, 1),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.work, 2),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.contact_mail, 3),
              label: 'Contact',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    return Obx(
      () => AnimatedContainer(
        duration: AppValues.animationDuration,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: controller.currentIndex.value == index
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppValues.radius),
        ),
        child: Icon(icon),
      ),
    );
  }
}
