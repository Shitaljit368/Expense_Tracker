import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Constant/colors.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:exptracker/Widgets/nextpage.dart';
import 'package:exptracker/Widgets/square_tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //signin
  Future signin() async {
    EasyLoading.show(status: "Please wait...");
    //try sign in
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: usernameController.text.trim(),
            password: passwordController.text.trim(),
          )
          .whenComplete(
            () => EasyLoading.showSuccess("okay"),
          );
      //pop the loading circle
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      EasyLoading.showError(e.code);
      //   if (e.code == 'user-not-found') {
      //     EasyLoading.dismiss();
      //     wrongEmailMessage();
      //   } else if (e.code == 'wrong-password') {
      //       log("${usernameController.text}");
      //  log("${passwordController.text}");
      //     EasyLoading.dismiss();
      //     wrongPasswordMessage();
      //   }
    }
  }

  //wrong email message popup
  // void wrongEmailMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text('Incorrect Email'),
  //       );
  //     },
  //   );
  // }

  //wrong password message popup
  // void wrongPasswordMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text('Incorrect password'),
  //       );
  //     },
  //   );
  // }

  bool visibility = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          Theme.of(context).colorScheme.background, //HexColor("#1C1C1C"),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),

                const Text(
                  'HEY THERE!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                //Welcome back, you've been missed!
                Text(
                  'Welcome back, you\'ve been missed! ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //Form___widget///////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Email__TextField
                        TextFormField(
                           cursorColor: Theme.of(context).colorScheme.primaryContainer,
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                              prefixIcon:  Icon(
                                CupertinoIcons.mail,
                                color: grey[500],
                              ),
                              hintText: 'name@example.com',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                              )),
                        ),
                        const SizedBox(height: 15),

                        //Password_field
                        TextFormField(
                          cursorColor: Theme.of(context).colorScheme.primaryContainer,
                          style: const TextStyle(fontSize: 16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          obscureText: !visibility,
                          controller: passwordController,
                          decoration: InputDecoration(
                              suffixIcon: visibility
                                  ? IconButton(
                                    
                                      onPressed: () {
                                        setState(() {
                                          visibility = !visibility;
                                        });
                                      },
                                      icon:  Icon(
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
                                      icon:  Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey[500],
                                        
                                      ),
                                    ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey[500])),
                        ),
                        //Forgot Password//////////////////////////////////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.router.push(
                                  const ForgotPasswordRoute(),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //Sign In Widget///////////////////////////////////////////////
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
                              if (_formKey.currentState!.validate()) {
                                signin();
                              } else {
                                EasyLoading.showError("Please fill the form");
                              }
                            },
                            child: const Text(
                              "Sign In",
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
                  height: 20,
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
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 16),
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
                  height: 25,
                ),

                const SquareTiles(imagepath: 'assests/images/newtwo.png'),
                const SizedBox(
                  height: 20,
                ),

                //Go to Sign In page
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextButton(
                    onPressed: () {
                      context.router.push(const SignInRoute());
                      // Navigator.push(context, SlideTransition1Page(const SignInPage()));
                    },
                    child: const NextPage(
                        notAMember: 'New User?  ', inLS: 'Sign Up'),
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
