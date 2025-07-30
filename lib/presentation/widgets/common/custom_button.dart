import 'package:flutter/material.dart';
import '../../../config/constants/colors.dart';
import '../../../config/constants/dimensions.dart';

enum ButtonType { primary, secondary, outlined, text }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? _getButtonHeight(),
      child: _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton(context);
      case ButtonType.secondary:
        return _buildSecondaryButton(context);
      case ButtonType.outlined:
        return _buildOutlinedButton(context);
      case ButtonType.text:
        return _buildTextButton(context);
    }
  }

  Widget _buildPrimaryButton(BuildContext context) {
    final bgColor = backgroundColor ?? context.colors.primary;
    final textColorValue = textColor ?? context.colors.onPrimary;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColorValue,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        padding: _getButtonPadding(),
        disabledBackgroundColor: bgColor.withAlpha(128),
        disabledForegroundColor: textColorValue.withAlpha(128),
      ),
      child: _buildButtonChild(context, textColorValue),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    final bgColor = backgroundColor ?? context.colors.surfaceContainerLowest;
    final textColorValue = textColor ?? context.colors.surfaceContainer;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColorValue,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        padding: _getButtonPadding(),
        disabledBackgroundColor: bgColor.withAlpha(128),
        disabledForegroundColor: textColorValue.withAlpha(128),
      ),
      child: _buildButtonChild(context, textColorValue),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    final borderColor = backgroundColor ?? context.colors.primary;
    final textColorValue = textColor ?? context.colors.primary;

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColorValue,
        side: BorderSide(color: borderColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        padding: _getButtonPadding(),
        disabledForegroundColor: textColorValue.withAlpha(128),
      ),
      child: _buildButtonChild(context, textColorValue),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    final textColorValue = textColor ?? context.colors.primary;

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColorValue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        padding: _getButtonPadding(),
        disabledForegroundColor: textColorValue.withAlpha(128),
      ),
      child: _buildButtonChild(context, textColorValue),
    );
  }

  Widget _buildButtonChild(BuildContext context, Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: _getLoadingSize(),
        height: _getLoadingSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: AppDimensions.paddingS),
          Text(text, style: _getTextStyle(context)?.copyWith(color: textColor)),
        ],
      );
    }

    return Text(
      text,
      style: _getTextStyle(context)?.copyWith(color: textColor),
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    switch (size) {
      case ButtonSize.small:
        return Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600);
      case ButtonSize.medium:
        return Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600);
      case ButtonSize.large:
        return Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36.0;
      case ButtonSize.medium:
        return AppDimensions.buttonHeight;
      case ButtonSize.large:
        return 56.0;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXL,
          vertical: AppDimensions.paddingL,
        );
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
    }
  }
}
