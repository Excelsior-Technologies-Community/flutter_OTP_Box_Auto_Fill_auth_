import 'package:flutter/material.dart';
import 'package:flutter_otp_box/flutter_otp_box.dart';

void main() {
  runApp(const OtpDemoApp());
}

class OtpDemoApp extends StatelessWidget {
  const OtpDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter OTP Box',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const OtpDemoScreen(),
    );
  }
}

class OtpDemoScreen extends StatefulWidget {
  const OtpDemoScreen({super.key});

  @override
  State<OtpDemoScreen> createState() => OtpDemoScreenState();
}

class OtpDemoScreenState extends State<OtpDemoScreen> {
  late final OtpController otpController;

  @override
  void initState() {
    super.initState();
    otpController = OtpController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _submitOtp() {
    final otp = otpController.value;

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 6-digit OTP')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('OTP submitted: $otp')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter OTP Box')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Enter the 6-digit OTP sent to your phone',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                OtpBox(
                  controller: otpController,
                  config: const OtpConfig(
                    length: 6,
                    autoFocus: true,
                    enableAutofill: true,
                    boxSize: 44,
                    spacing: 4,
                  ),
                  onCompleted: (value) {
                    debugPrint('OTP completed: $value');
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submitOtp,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
