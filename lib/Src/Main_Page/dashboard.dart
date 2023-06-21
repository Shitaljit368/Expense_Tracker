import 'package:auto_route/auto_route.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AppBarTheme/custom_theme.dart';
import '../../Color_Themes/dark_theme.dart';
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

  bool themeController = false;
  isDark() {
    if (themeController == false) {
      return themeData;
    }
    return darkTheme;
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
          tabName() {
            if (context.tabsRouter.activeIndex == 0) {
              return "Home";
            }
            return "Analytics";
          }

          return AppBar(
            centerTitle: true,
            title: Text(tabName()),
            elevation: 0,
          );
        },
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(37),
                bottomRight: Radius.circular(37)),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(36)),
                  ),
                  child: Image.asset(
                    "assests/images/finallogo.png",
                    fit: BoxFit.cover,
                  )),
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  MaterialButton(
                    onPressed: () {Navigator.pop(context);},
                    child: const DrawerItem(
                      name: "Documentation",
                      icon: CupertinoIcons.folder,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MaterialButton(
                    onPressed: () {Navigator.pop(context);},
                    child: const DrawerItem(
                        name: "About", icon: CupertinoIcons.info_circle),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const DrawerItem(
                      name: "Share",
                      icon: Icons.share,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        themeController = !themeController;
                       
                      });
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Switch(
                            value: themeController,
                            activeColor: Colors.black,
                            onChanged: (value) {},
                          ),
                          const Text(
                            "Dark Theme",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              title: Column(
                                children: [
                                  const Text("Are you sure?"),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 90,
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.grey)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "No",
                                            )),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: 90,
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.red)),
                                            onPressed: () {signUserOut();},
                                            child: const Text(
                                              "Yes",
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const DrawerItem(
                        
                        name: "Logout",
                        icon: Icons.logout_rounded,
                      )),
                  const SizedBox(
                    height: 275,
                  ),
                  const Divider(
                    color: Colors.black26,
                    endIndent: 20,
                    indent: 20,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Shital",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "${user.email}",
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ],
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
