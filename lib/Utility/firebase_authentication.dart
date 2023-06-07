import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Src/Main_Page/home_page.dart';
import '../Src/Login_module/Page/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } //User is logged in
          if (snapshot.hasData) {
            return const ExpenseBoardPage();

          }
          if (!snapshot.hasData) {
            return const LoginPage();
          }
          //user in not logged in
          else {
            return const Text("waiting...");
          }
        },
      ),
    );
  }
}
