import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_strings.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class SkillsSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.skillsKey,
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
              AppStrings.skillsTitle,
              style: TextStyle(
                fontSize: Responsive.fontSize(48),
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop ? 2 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 4,
                ),
                itemCount: controller.skills.length,
                itemBuilder: (context, index) {
                  final skill = controller.skills[index];
                  return Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppColors.cardGradient,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skill.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '${skill.level}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: skill.level / 100,
                          backgroundColor: AppColors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
