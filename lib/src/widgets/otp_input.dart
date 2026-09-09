import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/otp_controller.dart';
import 'otp_digit_box.dart';

class OtpInput extends StatefulWidget {
  final OtpController controller;
  final int length;
  final bool autoFocus;
  final bool enableAutofill;
  final bool obscureText;
  final double boxSize;
  final double spacing;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const OtpInput({
    super.key,
    required this.controller,
    this.length = 6,
    this.autoFocus = true,
    this.enableAutofill = true,
    this.obscureText = false,
    this.boxSize = 52,
    this.spacing = 10,
    this.onChanged,
    this.onCompleted,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  TextEditingController get textController => widget.controller.textController;

  FocusNode get focusNode => widget.controller.focusNode;

  @override
  void initState() {
    super.initState();

    textController.addListener(handleTextChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !widget.autoFocus) return;

      focusNode.requestFocus();
    });
  }

  void handleTextChanged() {
    if (!mounted) return;

    final value = textController.text;

    widget.onChanged?.call(value);

    if (value.length == widget.length) {
      widget.onCompleted?.call(value);
    }

    setState(() {});
  }

  void handleChanged(String value) {
    if (value.length <= widget.length) return;

    final trimmed = value.substring(0, widget.length);

    textController.value = TextEditingValue(
      text: trimmed,
      selection: TextSelection.collapsed(offset: trimmed.length),
    );
  }

  void handleTap() {
    if (!mounted || focusNode.hasFocus) return;

    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final text = textController.text;

    return AutofillGroup(
      child: SizedBox(
        height: widget.boxSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: TextField(
                controller: textController,
                focusNode: focusNode,
                autofocus: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: widget.length,
                showCursor: false,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(color: Colors.transparent, fontSize: 1),
                cursorColor: Colors.transparent,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  isCollapsed: true,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofillHints: widget.enableAutofill
                    ? const [AutofillHints.oneTimeCode]
                    : null,
                onChanged: handleChanged,
                onTap: handleTap,
              ),
            ),
            IgnorePointer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.length, (index) {
                  final value = index < text.length ? text[index] : '';

                  final isFocused =
                      focusNode.hasFocus &&
                      index == text.length &&
                      text.length < widget.length;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.spacing / 2,
                    ),
                    child: OtpDigitBox(
                      value: value,
                      isFocused: isFocused,
                      size: widget.boxSize,
                      obscureText: widget.obscureText,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.removeListener(handleTextChanged);
    super.dispose();
  }
}
