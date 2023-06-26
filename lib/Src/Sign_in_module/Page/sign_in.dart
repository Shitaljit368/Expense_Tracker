import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Constant/colors.dart';
import 'package:exptracker/Constant/datas.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:exptracker/Widgets/nextpage.dart';
import 'package:exptracker/Widgets/square_tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //controller
  final _usernameController = TextEditingController();
  final emailController = TextEditingController();
  final signinPasswordController = TextEditingController();
  final signinConfirmPasswordController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void createDocument() async {
    
    try {
      await firestore
          .collection('users')
          .doc(emailController.text)
          .set(userData)
          .whenComplete(() {
            EasyLoading.showSuccess("Success, your account has been created.");
        Navigator.pop(context);
        EasyLoading.dismiss();
      });
      log('Document created successfully');
    } catch (e) {
      EasyLoading.showError("Something went wrong", dismissOnTap: true);
      log('Error creating document: $e');
    }
  }

  //signin
  Future createAccount() async {
    if (passwordConfirmed()) {
      EasyLoading.show(status: "Please wait...");
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: signinPasswordController.text.trim(),
            )
            .whenComplete(() => createDocument());
      } on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.code);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('$e'),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Password Does not match'),
          );
        },
      );
    }
  }

  bool passwordConfirmed() {
    if (signinPasswordController.text.trim() ==
        signinConfirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
  void saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("emai", emailController.text);
  }

  bool visibility = false;
  bool visibility2 = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    signinPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                //Icon
                // Image.asset('assests/images/SW.png', height: 130,),
                // const SizedBox(
                //   height: 20,
                // ),

                //Welcome back, you've been missed!
                const Text(
                  'CREATE NEW ACCOUNT',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please fill in the form to continue',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                //textfield

                //Form___widget///////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _usernameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.person,
                              color: grey[500],
                            ),
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        //Email__TextField
                        TextFormField(
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.mail,
                              color: grey[500],
                            ),
                            hintText: 'name@example.com',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        const SizedBox(height: 10),

                        //Password_field
                        TextFormField(
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          obscureText: !visibility,
                          controller: signinPasswordController,
                          decoration: InputDecoration(
                            suffixIcon: visibility
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visibility = !visibility;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.grey[500],
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visibility = !visibility;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        const SizedBox(height: 10),

                        //Password_field
                        TextFormField(
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          obscureText: !visibility2,
                          controller: signinConfirmPasswordController,
                          decoration: InputDecoration(
                            suffixIcon: visibility2
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visibility2 = !visibility2;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.grey[500],
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visibility2 = !visibility2;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        //Forgot Password//////////////////////////////////////////

                        const SizedBox(
                          height: 20,
                        ),

                        //Sign In Widget///////////////////////////////////////////////
                        SizedBox(
                          height: 57,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(HexColor("#009E60")),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                createAccount();
                                saveEmail();
                              } else {
                                EasyLoading.showError("Please fill all form");
                              }
                            },
                            child: const Text(
                              "Create account",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), ///////////////////////////////////
                ),

                const SizedBox(
                  height: 15,
                ),
                //lineDivider-----------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Sign in with Google
                const SquareTiles(imagepath: 'assests/images/newtwo.png'),
                const SizedBox(
                  height: 15,
                ),

                //Next Page widget
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextButton(
                    onPressed: () {
                      context.router.push(const AuthFlowRoute());
                      // Navigator.push(
                      //     context, SlideTransition2Page(const LoginPage()));
                    },
                    child: const NextPage(
                        notAMember: 'Already have an account?  ',
                        inLS: 'Log In'),
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
