import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import '../../Constant/colors.dart';
import 'Home_page_widgets/read_plans_home.dart';
import 'Home_page_widgets/read_recent_data.dart';

class ExpenseBoardPage extends StatefulWidget {
  const ExpenseBoardPage({super.key});

  @override
  State<ExpenseBoardPage> createState() => _ExpenseBoardPageState();
}

class _ExpenseBoardPageState extends State<ExpenseBoardPage> {
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  num incomeTotal = 0;
  num expenseTotal = 0;
  num finalTotal = 0;


  final _formKey = GlobalKey<FormState>();

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: SpeedDial(
        animationDuration: const Duration(milliseconds: 150),
        backgroundColor: hexGreen,
        foregroundColor: white,
        icon: Icons.file_open_outlined,
        activeIcon: Icons.close,
        activeBackgroundColor: Colors.red,
        children: [
          SpeedDialChild(
              onTap: () {
                //Quick add bottom sheet
                quickAdd(context);
              },
              backgroundColor: Colors.cyan,
              child: const Icon(
                Icons.add,
                size: 35,
                color: Colors.black,
              ),
              label: "Quick Add"),

          //Expense list page route
          SpeedDialChild(
              onTap: () {
                context.router.push(const MyExpenseListRoute());
              },
              backgroundColor: Colors.amberAccent,
              child: Icon(
                Icons.monetization_on,
                size: 30,
                color: opBlack,
              ),
              label: "Expenses"),

          //Future savings list route
          SpeedDialChild(
              onTap: () {
                context.router.push(const MySavingsListRoute());
              },
              backgroundColor: Colors.blue.shade200,
              child: Icon(
                Icons.add_home_work_rounded,
                size: 30,
                color: opBlack,
              ),
              label: "Plans"),

          //Income list route
          SpeedDialChild(
              onTap: () {
                context.router.push(const MyIncomeListRoute());
              },
              backgroundColor: Colors.red.shade400,
              child: Icon(
                Icons.token_sharp,
                size: 30,
                color: opBlack,
              ),
              label: "Income"),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: opBlack,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            // border: Border.all(color: Colors.white10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.email)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    var d = snapshot.data?.data();
                                    var f = d?["incomes"] as List;
                                    int totalAmount = 0;
                                    for (var income in f) {
                                      int? amount = int.tryParse(
                                          income['amount'].replaceAll(',', ''));
                                      if (amount != null) {
                                        totalAmount += amount;
                                        incomeTotal = totalAmount;
                                      }
                                    }

                                    log(totalAmount.toString());
                                  }
                                  if (snapshot.hasData) {
                                    var d = snapshot.data?.data();
                                    var f = d?["expenses"] as List;
                                    int totalAmount = 0;
                                    for (var income in f) {
                                      int? amount = int.tryParse(
                                          income['amount'].replaceAll(',', ''));
                                      if (amount != null) {
                                        totalAmount += amount;
                                        expenseTotal = totalAmount;
                                      }
                                    }

                                    log(totalAmount.toString());
                                  }
                                  finalTotal = (incomeTotal - expenseTotal);
                                  return FittedBox(
                                    child: Text(
                                      "$finalTotal",
                                      style: const TextStyle(
                                        color: white,
                                        fontSize: 38,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "TOTAL INCOME",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(user.email)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<
                                                    DocumentSnapshot<
                                                        Map<String, dynamic>>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            var d = snapshot.data?.data();
                                            var f = d?["incomes"] as List;
                                            int totalAmount = 0;
                                            for (var income in f) {
                                              int? amount = int.tryParse(
                                                  income['amount']
                                                      .replaceAll(',', ''));
                                              if (amount != null) {
                                                totalAmount += amount;
                                                incomeTotal = totalAmount;
                                              }
                                            }

                                            log(totalAmount.toString());
                                          }
                                          return FittedBox(
                                            child: Text(
                                              "+$incomeTotal",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.greenAccent
                                                      .withOpacity(0.5)),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "TOTAL EXPENSES",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(user.email)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<
                                                    DocumentSnapshot<
                                                        Map<String, dynamic>>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            var d = snapshot.data?.data();
                                            var f = d?["expenses"] as List;
                                            int totalAmount = 0;
                                            for (var income in f) {
                                              int? amount = int.tryParse(
                                                  income['amount']
                                                      .replaceAll(',', ''));
                                              if (amount != null) {
                                                totalAmount += amount;
                                                expenseTotal = totalAmount;
                                              }
                                            }

                                            log(totalAmount.toString());
                                          }
                                          return FittedBox(
                                            child: Text(
                                              "-$expenseTotal",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.redAccent
                                                      .withOpacity(0.7)),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "My Future Plans",
                              style: TextStyle(fontSize: 16, color: grey),
                            ),
                            TextButton(
                              onPressed: () => context.router.push(
                                const MySavingsListRoute(),
                              ),
                              child: const Text(
                                "See All",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Expanded(
                  child: Container(
                    // height: 242,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 15),
                          child: Row(
                            children: const [
                              Text(
                                "Recent Activities",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 210,
                          child: ReadRecentDataPage(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Savings Widget
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 210, 0, 0),
              child: SizedBox(
                height: 170,
                child: ReadFutureOnHome(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> quickAdd(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
        padding: EdgeInsets.only(
            top: 0,
            right: 25,
            left: 25,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 5,
                    width: 70,
                    decoration: BoxDecoration(
                        color: opBlack,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
              
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Quick Add",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.teal,
                                  onPrimary: Colors.white,
                                  onSurface: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
      
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('d,EEE,y').format(pickedDate);
                          setState(() {
                            dateInputController.text = formattedDate;
                          });
                        } else {}
                      },
                      style: const TextStyle(fontSize: 16),
                      readOnly: true,
                      controller: dateInputController,
                      decoration: const InputDecoration(
                          hintText: "Date",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                          ),
                          prefixIconColor: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    width: 155,
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: grey[500],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Remark',
                  prefixIcon: Icon(
                    Icons.edit,
                    color: grey[500],
                  ),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            splashFactory:
                                InkSparkle.constantTurbulenceSeedSplashFactory,
                            overlayColor:
                                MaterialStatePropertyAll(Colors.grey.shade100)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        )),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(colors: [
                          Colors.tealAccent,
                          Colors.deepPurple,
                        ]),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(10, 10),
                              blurRadius: 30,
                              color: Colors.black.withOpacity(0.15))
                        ]),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {},
                      child: const Text(
                        "Add",
                        style: TextStyle(color: white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
      },
    );
  }
}
