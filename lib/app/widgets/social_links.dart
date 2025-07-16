import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/values/app_colors.dart';

import '../core/values/app_strings.dart';
import '../modules/home/controllers/home_controller.dart';

class SocialLinks extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
          icon: Icons.code,
          url: AppStrings.githubUrl,
          tooltip: 'GitHub',
        ),
        SizedBox(width: 16),
        _buildSocialIcon(
          icon: Icons.work,
          url: AppStrings.linkedinUrl,
          tooltip: 'LinkedIn',
        ),
        SizedBox(width: 16),
        _buildSocialIcon(
          icon: Icons.alternate_email,
          url: 'mailto:${AppStrings.email}',
          tooltip: 'Email',
        ),
        SizedBox(width: 16),
        _buildSocialIcon(
          icon: Icons.phone,
          url: 'tel:${AppStrings.phone}',
          tooltip: 'Phone',
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () => controller.launchURL(url),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
      ),
    );
  }
}
