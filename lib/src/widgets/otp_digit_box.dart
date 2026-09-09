import 'package:flutter/material.dart';

class OtpDigitBox extends StatelessWidget {
  final String value;
  final bool isFocused;
  final double size;
  final bool obscureText;

  const OtpDigitBox({
    super.key,
    required this.value,
    required this.isFocused,
    this.size = 52,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
          width: isFocused ? 2 : 1,
        ),
      ),
      child: Text(
        value.isEmpty
            ? ''
            : obscureText
            ? '•'
            : value,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}