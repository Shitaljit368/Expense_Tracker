import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../Constant/colors.dart';
import 'Home_page_widgets/read_expense_data.dart';

class MyExpenseListPage extends StatefulWidget {
  const MyExpenseListPage({super.key});

  @override
  State<MyExpenseListPage> createState() => _MyExpenseListPageState();
}

class _MyExpenseListPageState extends State<MyExpenseListPage> {
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection("users");
  int? ttotalAmount;

  Future<void> addData() async {
    final CollectionReference expensesCollection =
        FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> newExpenseData = {
      "name": remarkController.text,
      "image": "",
      "amount": amountController.text,
      "date": dateInputController.text,
    };

    log(newExpenseData.toString());
    DocumentReference documentRef = expensesCollection.doc(user.email);
    documentRef.update({
      'expenses': FieldValue.arrayUnion([newExpenseData])
    }).then((_) {
      log("Expense data added");
    }).catchError((error) {
      log("Failed to add expense data: $error");
    });
  }

  Future<void> addRecentData() async {
    final CollectionReference recentCollection =
        FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> newRecentData = {
      "name": remarkController.text,
      "image": "",
      "amount": amountController.text,
      "date": dateInputController.text,
    };

    log(newRecentData.toString());
    DocumentReference documentRef = recentCollection.doc(user.email);
    documentRef.update({
      'recent_activities': FieldValue.arrayUnion([newRecentData])
    }).then((_) {
      log("Recent data added");
    }).catchError((error) {
      log("Failed to add recent data: $error");
    });
  }

  @override
  void initState() {
    dateInputController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                addItem(context);
              },
              icon: const Icon(Icons.add))
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text("My Expenses"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.email)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasData) {
                  var d = snapshot.data?.data();
                  var f = d?["expenses"] as List;
                  int totalAmount = 0;
                  for (var income in f) {
                    int? amount =
                        int.tryParse(income['amount'].replaceAll(',', ''));
                    if (amount != null) {
                      totalAmount += amount;
                      ttotalAmount = totalAmount;
                    }
                  }

                  log(totalAmount.toString());
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 30,
                  width: double.infinity,
                  color: opBlack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          "Total Amount: $ttotalAmount",
                          style: const TextStyle(fontSize: 18, color: white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 3,
            ),
            const ReadExpenseDataPage(),
          ],
        ),
      ),
    );
  }

  Future<dynamic> addItem(BuildContext context) {
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
                  "Create a new expense item",
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
                      controller: amountController,
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
                controller: remarkController,
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
                          dateInputController.clear();
                          remarkController.clear();
                          amountController.clear();
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addData().whenComplete(
                            () {
                              addRecentData();
                              Navigator.pop(context);
                              amountController.clear();
                              dateInputController.clear();
                              remarkController.clear();
                              return EasyLoading.showSuccess("New task added!");
                            },
                          );
                        } else {
                          EasyLoading.showError("Please fill in the form");
                        }
                      },
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
      ),
    );
  }
}
