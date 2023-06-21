import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Src/Main_Page/Home_page_widgets/future_plans.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import '../../Constant/colors.dart';

class ExpenseBoardPage extends StatefulWidget {
  const ExpenseBoardPage({super.key});

  @override
  State<ExpenseBoardPage> createState() => _ExpenseBoardPageState();
}

class _ExpenseBoardPageState extends State<ExpenseBoardPage> {
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController incomeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  List<Map<String, dynamic>> data = [
    {"Name": "Food", "Amount": -500, "Date": "02/05/2023"},
    {"Name": "Fuel", "Amount": -555, "Date": "05/05/2023"},
    {"Name": "Cloths", "Amount": -3000, "Date": "10/05/2023"},
  ];

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
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            // boxShadow: [
                            //   const BoxShadow(
                            //       blurRadius: 20,
                            //       spreadRadius: 1,
                            //       offset: Offset(5, 5),
                            //       color: Colors.black),
                            //   BoxShadow(
                            //       blurRadius: 20,
                            //       spreadRadius: 1,
                            //       offset: const Offset(-5, -5),
                            //       color:
                            //           Colors.grey.shade800.withOpacity(0.6)),
                            // ]
                            //   gradient: LinearGradient(colors: [
                            //     Colors.white,
                            //     Colors.red,
                            //     Colors.deepPurple.shade500,
                            //     Colors.white,
                            //   ]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "0",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 42,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        "Total income",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "+0",
                                        style: TextStyle(
                                            fontSize: 26, color: grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Text(
                                        "Total expense",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "-0",
                                        style: TextStyle(
                                            fontSize: 26, color: grey),
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
                              child: Text(
                                "See All",
                                style: TextStyle(fontSize: 16, color: hexGreen),
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
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
                        SizedBox(
                          height: 210,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                dragStartBehavior: DragStartBehavior.start,
                                endActionPane: ActionPane(
                                    extentRatio: 0.3,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {},
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ]),
                                child: ListTile(
                                  enableFeedback: true,
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "🚘",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data[index]["Name"].toString(),
                                        style:
                                            const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        data[index]["Amount"].toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle:
                                      Text(data[index]["Date"].toString()),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Savings Widget
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 200, 0, 0),
              child: SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const SavingsWidget();
                  },
                ),
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
      builder: (context) => Padding(
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
                  "Create a new income item",
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
                      style: const TextStyle(fontSize: 18),
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
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      newHexGreen,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    } else {
                      EasyLoading.showError("Please fill in the form");
                    }
                  },
                  child: const Text("Confirm"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
