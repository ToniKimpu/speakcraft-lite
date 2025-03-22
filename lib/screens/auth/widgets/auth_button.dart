import 'package:flutter/material.dart';

enum AuthButtonVariant {
  filled,
  outlined,
  text,
}

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AuthButtonVariant variant;
  final bool fullWidth;
  final Widget? icon;
  final Color? textColor;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.variant = AuthButtonVariant.filled,
    this.fullWidth = true,
    this.icon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final buttonStyle = switch (variant) {
      AuthButtonVariant.filled => ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      AuthButtonVariant.outlined => OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(
            color: colorScheme.outline,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      AuthButtonVariant.text => TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
    };

    final textStyle = TextStyle(
      color: textColor ??
          (variant == AuthButtonVariant.filled
              ? colorScheme.onPrimary
              : colorScheme.primary),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    final child = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == AuthButtonVariant.filled
                    ? colorScheme.onPrimary
                    : colorScheme.primary,
              ),
            ),
          )
        else ...[
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: variant == AuthButtonVariant.filled
                    ? colorScheme.onPrimary
                    : colorScheme.primary,
              ),
              child: icon!,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: textStyle,
          ),
        ],
      ],
    );

    return switch (variant) {
      AuthButtonVariant.filled => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AuthButtonVariant.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AuthButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
    };
  }
}
