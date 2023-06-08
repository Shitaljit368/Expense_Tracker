import 'package:auto_route/auto_route.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constant/colors.dart';
import '../Router/router.gr.dart';
import 'drawer_item.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    getEmail();
    super.initState();
  }

  String? email;
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        appBarBuilder: (context, tabsRouter) {
          return AppBar(
            centerTitle: true,
            title: Text(context.topRoute.name),
            elevation: 0,
          );
        },
        drawer: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
          child: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Column(
                    children:  [
                      const CircleAvatar(
                        radius: 45,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "Kh Shitaljit",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        email ?? " ",
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const DrawerItem(
                      name: "Settings",
                      icon: CupertinoIcons.settings_solid,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const DrawerItem(
                        name: "About", icon: CupertinoIcons.info_circle),
                    const SizedBox(
                      height: 5,
                    ),
                    const DrawerItem(
                        name: "Feedback", icon: Icons.message_outlined),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          signUserOut();
                        },
                        child: const DrawerItem(
                          name: "Logout",
                          icon: Icons.logout_rounded,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 300),
        routes: const [
          ExpenseBoardRoute(),
          ChartRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return CustomNavigationBar(
            elevation: 20,
            backgroundColor: Theme.of(context).colorScheme.primary,
            strokeColor: newHexGreen,
            selectedColor: Theme.of(context).colorScheme.primaryContainer,
            iconSize: 26,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: [
              CustomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.house_fill,
                ),
              ),
              CustomNavigationBarItem(
                icon: const Icon(CupertinoIcons.graph_square_fill),
              ),
            ],
          );
        },
      ),
    );
  }
}
