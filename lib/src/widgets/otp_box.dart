import 'package:flutter/material.dart';

import '../controllers/otp_controller.dart';
import '../models/otp_config.dart';
import 'otp_input.dart';

class OtpBox extends StatefulWidget {
  final OtpConfig config;
  final OtpController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const OtpBox({
    super.key,
    this.config = const OtpConfig(),
    this.controller,
    this.onChanged,
    this.onCompleted,
  });

  @override
  State<OtpBox> createState() => OtpBoxState();
}

class OtpBoxState extends State<OtpBox> {
  late final OtpController _internalController;

  OtpController get _controller =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = OtpController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OtpInput(
      controller: _controller,
      length: widget.config.length,
      autoFocus: widget.config.autoFocus,
      enableAutofill: widget.config.enableAutofill,
      obscureText: widget.config.obscureText,
      boxSize: widget.config.boxSize,
      spacing: widget.config.spacing,
      onChanged: widget.onChanged,
      onCompleted: widget.onCompleted,
    );
  }
}