import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/values/app_colors.dart';
import 'package:portfolio/app/core/values/app_strings.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/app/widgets/animated_button.dart';

class ContactSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.contactKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop ? 80 : 20,
        vertical: 100,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Text(
              AppStrings.contactTitle,
              style: TextStyle(
                fontSize: Responsive.fontSize(48),
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              AppStrings.contactDescription,
              style: TextStyle(
                fontSize: Responsive.fontSize(18),
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            _buildContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Responsive.isDesktop
              ? Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: controller.nameController,
                        label: AppStrings.contactFormName,
                        icon: Icons.person,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: controller.emailController,
                        label: AppStrings.contactFormEmail,
                        icon: Icons.email,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildTextField(
                      controller: controller.nameController,
                      label: AppStrings.contactFormName,
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: controller.emailController,
                      label: AppStrings.contactFormEmail,
                      icon: Icons.email,
                    ),
                  ],
                ),
          SizedBox(height: 20),
          _buildTextField(
            controller: controller.messageController,
            label: AppStrings.contactFormMessage,
            icon: Icons.message,
            maxLines: 5,
          ),
          SizedBox(height: 30),
          Obx(
            () => AnimatedButton(
              text: controller.isSubmittingForm.value
                  ? AppStrings.loadingSubmitting
                  : AppStrings.contactFormSubmit,
              onPressed: controller.submitContactForm,
              isLoading: controller.isSubmittingForm.value,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(icon, color: AppColors.primary),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
