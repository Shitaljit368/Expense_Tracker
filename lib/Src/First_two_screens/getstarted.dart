import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 250,
                  child: Image.asset('assests/images/getstarted2.png'),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children:  [
                    Text(
                      "Let's Get Started.",
                      style: GoogleFonts.barlowCondensed(fontSize: 40,color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Easiest way to track your daily expenses.",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const SignInRoute());
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color.fromARGB(255, 234, 50, 50)),
                      mouseCursor: MaterialStatePropertyAll(MouseCursor.defer),
                    ),
                    child: const Text(
                      "Create account",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const LoginRoute());
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      mouseCursor: MaterialStatePropertyAll(MouseCursor.defer),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
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
