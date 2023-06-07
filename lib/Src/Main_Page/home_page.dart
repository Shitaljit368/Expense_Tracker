import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Src/Main_Page/Home_page_widgets/future_plans.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hexcolor/hexcolor.dart';
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
    {"Name": "Food", "Amount": 500, "Date": "02/05/2023"},
    {"Name": "Fuel", "Amount": 555, "Date": "05/05/2023"},
    {"Name": "Cloths", "Amount": 3000, "Date": "10/05/2023"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: SpeedDial(
        animationDuration: const Duration(milliseconds: 150),
        backgroundColor: hexGreen,
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
              child: Icon(
                Icons.add,
                size: 40,
                color: opBlack,
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
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            // gradient: LinearGradient(
                            //   // begin: const Alignment(-1,0),
                            //   // end: const Alignment(0, 1),
                            //   colors: [
                            //   Colors.grey.shade300,
                            //   Colors.teal,
                            //   hexGreen
                            // ]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 24, 30, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Total amount",
                                  style: TextStyle(color: grey, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "10,000",
                                  style: TextStyle(fontSize: 40, color: white),
                                ),
                              ],
                            ),
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
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return MaterialButton(
                                onPressed: () {},
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
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        data[index]["Amount"].toString(),
                                        style: const TextStyle(fontSize: 19),
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

            //Savings
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
      isDismissible: false,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            top: 0,
            right: 40,
            left: 40,
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
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 50,
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
                  "Income/Expenses/Plans",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2050),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      dateInputController.text = formattedDate;
                    });
                  }
                },
                readOnly: true,
                controller: dateInputController,
                decoration: const InputDecoration(
                  hintText: "Enter Date",
                  hintStyle: TextStyle(color: grey),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: grey,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: incomeController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Event name',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: amountController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Amount',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 145,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: const MaterialStatePropertyAll(
                          Colors.white12,
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          opBlack,
                        ),
                      ),
                      onPressed: () {
                        dateInputController.clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: 145,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          HexColor("#009E60"),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        } else {
                          EasyLoading.showError("Please fill the form");
                        }
                      },
                      child: const Text("OK"),
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
      ),
    );
  }
}
