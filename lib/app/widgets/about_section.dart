import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_strings.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class AboutSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.aboutKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop ? 80 : 20,
        vertical: 100,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            Text(
              AppStrings.aboutTitle,
              style: TextStyle(
                fontSize: Responsive.fontSize(48),
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Text(
              AppStrings.aboutDescription,
              style: TextStyle(
                fontSize: Responsive.fontSize(18),
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Responsive.isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHighlight(AppStrings.aboutHighlight1),
                      _buildHighlight(AppStrings.aboutHighlight2),
                      _buildHighlight(AppStrings.aboutHighlight3),
                      _buildHighlight(AppStrings.aboutHighlight4),
                    ],
                  )
                : Column(
                    children: [
                      _buildHighlight(AppStrings.aboutHighlight1),
                      SizedBox(height: 16),
                      _buildHighlight(AppStrings.aboutHighlight2),
                      SizedBox(height: 16),
                      _buildHighlight(AppStrings.aboutHighlight3),
                      SizedBox(height: 16),
                      _buildHighlight(AppStrings.aboutHighlight4),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlight(String text) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Responsive.fontSize(14),
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
