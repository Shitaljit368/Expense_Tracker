import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exptracker/Src/Main_Page/Home_page_widgets/read_income_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../Constant/colors.dart';

class MyIncomeListPage extends StatefulWidget {
  const MyIncomeListPage({super.key});

  @override
  State<MyIncomeListPage> createState() => _MyIncomeListPageState();
}

class _MyIncomeListPageState extends State<MyIncomeListPage> {
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  

  Future<void> addData() async {
    final CollectionReference incomesCollection =
        FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> newIncomeData = {

      "name": remarkController.text,
      "image": "",
      "amount": amountController.text,
      "date": dateInputController.text,
    };

    log(newIncomeData.toString());
    DocumentReference documentRef = incomesCollection.doc(user.email);
    documentRef.update({
      'incomes': FieldValue.arrayUnion([newIncomeData])
    }).then((_) {
      print("Income data added");
    }).catchError((error) {
      print("Failed to add income data: $error");
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
        title: const Text("My Incomes"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 30,
              width: double.infinity,
              color: opBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Total: 1700",
                    style: TextStyle(fontSize: 18, color: white),
                  ),
                ],
              ),
            ),
            
            const SizedBox(
              height: 1,
            ),
            const ReadIcomeDataPage(),
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
                                          textButtonTheme:
                                              TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  Theme.of(context)
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
                                        DateFormat('d,EEE,y')
                                            .format(pickedDate);
                                    setState(() {
                                      dateInputController.text =
                                          formattedDate;
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              
                                style: const TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[500]),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 160,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      const MaterialStatePropertyAll(
                                    Colors.white12,
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                    opBlack,
                                  ),
                                ),
                                onPressed: () {
                                  dateInputController.clear();
                                  remarkController.clear();
                                  amountController.clear();
                               
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 160,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    newHexGreen,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {

                                    
                                    addData().whenComplete(
                                      () {
                                        Navigator.pop(context);
                                        amountController.clear();
                                        dateInputController.clear();
                                        remarkController.clear();
                                        return EasyLoading.showSuccess(
                                            "new task added!");
                                      },
                                    );
                                  } else {
                                    EasyLoading.showError(
                                        "Please fill in the form");
                                  }
                                },
                                child: const Text("Confirm"),
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
