import 'package:exptracker/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SavePasswordPage extends StatefulWidget {
  const SavePasswordPage({super.key});

  @override
  State<SavePasswordPage> createState() => _SavePasswordPageState();
}

class _SavePasswordPageState extends State<SavePasswordPage> {
  bool isChecked = false;
  final __formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();
  bool isConfirmedPassword() {
    if (newPasswordController.text.trim() ==
        newConfirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create New Password'),
        elevation: 0,
        backgroundColor: opBlack,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 30),
              //   child: Image.asset(
              //     'assests/images/cnfused.png',
              //     height: 150,
              //   ),
              // ),
              const Text(
                "Your new password must be different",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "from previously used password",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: __formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          obscureText: !isChecked,
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: newPasswordController,
                          decoration: InputDecoration(
                              hintText: "New password",
                              hintStyle: TextStyle(color: Colors.grey[500])),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          cursorColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          obscureText: !isChecked,
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: newConfirmPasswordController,
                          decoration: InputDecoration(
                              hintText: " Confirm new password",
                              hintStyle: TextStyle(color: Colors.grey[500])),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.blue),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                            ),
                            Text("Show password?",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        //Sign In Widget///////////////////////////////////////////////
                        SizedBox(
                          height: 57,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(newHexGreen),
                              mouseCursor: const MaterialStatePropertyAll(
                                  MouseCursor.defer),
                            ),
                            onPressed: () {
                              if (__formKey.currentState!.validate()) {
                              } else {
                                EasyLoading.showError("Please fill all form");
                              }
                            },
                            child: const Text(
                              "Save Password",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
