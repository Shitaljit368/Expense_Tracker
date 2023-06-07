import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Constant/colors.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pinput.dart';

class VerifyPasswordPage extends StatefulWidget {
  const VerifyPasswordPage({super.key});

  @override
  State<VerifyPasswordPage> createState() => _VerifyPasswordPageState();
}

class _VerifyPasswordPageState extends State<VerifyPasswordPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = HexColor("#009E60");
    // final fillColor = hexGreen.withOpacity(0.2);
    final borderColor = Theme.of(context).colorScheme.primaryContainer;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 24,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Validate OTP",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HexColor("#1C1C1C"),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Varification",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Enter the 4-digit code sent to the number",
                  style: TextStyle(
                    fontSize: 16,
                    // color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "name@example.com",
                  style: TextStyle(
                    fontSize: 18,
                    color: hexGreen,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: pinController,
                    focusNode: focusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    validator: (value) {
                      return value == '2222' ? null : 'Pin is incorrect';
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        // color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Didn\'t receive any code?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Resend',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        HexColor("#009E60"),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        focusNode.unfocus();
                        context.router.push(const SavePasswordRoute());
                        pinController.clear();
                      } else {
                        EasyLoading.showError("OTP code required");
                      }
                    },
                    child: const Text(
                      "Validate",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
