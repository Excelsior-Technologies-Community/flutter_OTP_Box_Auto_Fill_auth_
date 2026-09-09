import 'package:flutter/widgets.dart';

class OtpController {
  final TextEditingController textController;
  final FocusNode focusNode;

  OtpController()
      : textController = TextEditingController(),
        focusNode = FocusNode();

  String get value => textController.text;

  void clear() {
    textController.clear();
  }

  void focus() {
    focusNode.requestFocus();
  }

  void dispose() {
    textController.dispose();
    focusNode.dispose();
  }
}