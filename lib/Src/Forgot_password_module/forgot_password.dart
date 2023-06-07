import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _forgotController = TextEditingController();
  final _fformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HexColor("#1C1C1C"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
            key: _fformKey,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Image.asset(
                        'assests/images/green.png',
                        height: 150,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Please Enter Your Email Address To",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "Receive a Verification Code.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      cursorColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      style: const TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _forgotController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.grey[500],
                        ),
                        hintText: 'name@example.com',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 57,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            HexColor("#009E60"),
                          ),
                        ),
                        onPressed: () {
                          if (_fformKey.currentState!.validate()) {
                            context.router.push(const VerifyPasswordRoute());
                          } else {
                            EasyLoading.showError("Please fill in your email");
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
