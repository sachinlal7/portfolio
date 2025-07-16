import 'package:flutter/material.dart';
import 'package:portfolio/app/core/values/app_colors.dart';

import '../core/utils/responsive.dart';
import '../core/values/app_durations.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const AnimatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppDurations.buttonPress,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height ?? 50,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.spacing(24),
                vertical: Responsive.spacing(12),
              ),
              decoration: BoxDecoration(
                gradient: widget.isPrimary ? AppColors.primaryGradient : null,
                color: widget.isPrimary ? null : Colors.transparent,
                border: widget.isPrimary
                    ? null
                    : Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(30),
                boxShadow: widget.isPrimary
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.isPrimary ? Colors.white : AppColors.primary,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: widget.isPrimary
                                ? Colors.white
                                : AppColors.primary,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(16),
                            fontWeight: FontWeight.w600,
                            color: widget.isPrimary
                                ? Colors.white
                                : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
