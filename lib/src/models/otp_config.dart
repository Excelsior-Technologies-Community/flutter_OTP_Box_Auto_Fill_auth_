class OtpConfig {
  final int length;
  final bool obscureText;
  final bool autoFocus;
  final bool enableAutofill;
  final double boxSize;
  final double spacing;

  const OtpConfig({
    this.length = 6,
    this.obscureText = false,
    this.autoFocus = true,
    this.enableAutofill = true,
    this.boxSize = 52,
    this.spacing = 10,
  });
}