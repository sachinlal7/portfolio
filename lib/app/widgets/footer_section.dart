import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_strings.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/app/widgets/social_links.dart';

class FooterSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop ? 80 : 20,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border.withOpacity(0.3)),
        ),
      ),
      child: Column(
        children: [
          Responsive.isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.footerCopyright,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      AppStrings.footerBuiltWith,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      AppStrings.footerCopyright,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      AppStrings.footerBuiltWith,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
          SizedBox(height: 20),
          SocialLinks(),
        ],
      ),
    );
  }
}
