import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class NavBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop ? 80 : 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          if (Responsive.isDesktop) _buildDesktopNavigation(),
          _buildActionButtons(),
          if (!Responsive.isDesktop) _buildMobileMenuButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () => controller.scrollToSection(controller.heroKey),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'JD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (Responsive.isDesktop) ...[
            SizedBox(width: 12),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      children: [
        _buildNavItem('Home', 0, controller.heroKey),
        _buildNavItem('About', 1, controller.aboutKey),
        _buildNavItem('Skills', 2, controller.skillsKey),
        _buildNavItem('Experience', 3, controller.experienceKey),
        _buildNavItem('Projects', 4, controller.projectsKey),
        _buildNavItem('Contact', 5, controller.contactKey),
      ],
    );
  }

  Widget _buildNavItem(String title, int index, GlobalKey key) {
    return Obx(() {
      final isActive = controller.currentNavIndex.value == index;
      return GestureDetector(
        onTap: () => controller.scrollToSection(key),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive ? AppColors.primary.withOpacity(0.1) : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        IconButton(
          onPressed: controller.toggleTheme,
          icon: Obx(
            () => Icon(
              controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.textSecondary,
            ),
          ),
          tooltip: 'Toggle Theme',
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => controller.scrollToSection(controller.contactKey),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Hire Me',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      onPressed: controller.toggleMenu,
      icon: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Icon(
            controller.isMenuOpen.value ? Icons.close : Icons.menu,
            key: ValueKey(controller.isMenuOpen.value),
            color: AppColors.textPrimary,
            size: 28,
          ),
        ),
      ),
    );
  }
}
