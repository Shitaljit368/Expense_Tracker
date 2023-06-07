import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../Constant/colors.dart';

class MyExpenseListPage extends StatefulWidget {
  const MyExpenseListPage({super.key});

  @override
  State<MyExpenseListPage> createState() => _MyExpenseListPageState();
}

class _MyExpenseListPageState extends State<MyExpenseListPage> {

  final CollectionReference expenseRef =
      FirebaseFirestore.instance.collection('expenses');
  // void addUser(String expenseName, int amount, String date, ) {
  // // Add a new document with a generated ID to the "users" collection
  // usersRef.doc().set(
  //   'name_of_expense': expenseName,
  //   'email': amount,
  //   'date': date,)
  // }
  // .then((value) => print("User added successfully"))
  // .catchError((error) => print("Failed to add user: $error"));
  TextEditingController expnameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    dateInputController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    dateInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
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
                                  Container(
                                    height: 5,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: opBlack,
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
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
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2050),
                                  );

                                  if (pickedDate != null) {
                                    // print(
                                    //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);

                                    // print(
                                    //     formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInputController.text = formattedDate;
                                      //set output date to TextField value.
                                    });
                                  } else {}
                                },
                                readOnly: true,
                                controller: dateInputController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Date',
                                    hintStyle: TextStyle(color: grey),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: grey,
                                    )),
                              ),
                              const SizedBox(height: 8.0),
                              TextFormField(
                                controller: expnameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 20),
                                decoration: const InputDecoration(
                                  hintText: 'Expense Item',
                                  hintStyle: TextStyle(color: grey),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: amountController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 20),
                                decoration: const InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle: TextStyle(color: grey),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 145,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        overlayColor:
                                            const MaterialStatePropertyAll(
                                          Colors.white12,
                                        ),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary),
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          newHexGreen,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
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
                  },
                  icon: const Icon(Icons.add))
            ],
            elevation: 0,
            centerTitle: true,
            title: const Text("My Expenses"),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Total: 10,000",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: grey,
                endIndent: 15,
                indent: 15,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              // Expanded(
              //   child: ListView.builder(
              //           physics: const BouncingScrollPhysics(),
              //           // itemCount: data.length,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               color:Theme.of(context).colorScheme.primary,
              //               child: ListTile(
              //                 enableFeedback: true,
              //                 leading: Container(
              //                   height: 50,
              //                   width: 50,
              //                   decoration: BoxDecoration(
              //                       color: Colors.grey[200],
              //                       borderRadius:
              //                           BorderRadius.circular(10)),
              //                   child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.center,
              //                     children: const [
              //                       Text(
              //                         "🚘",
              //                         style: TextStyle(fontSize: 30),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 title: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: const [
                                  
                                  
              //                   ],
              //                 ),
                              
                                  
              
              //               ),
              //             );
              //           },
              //         ),
              // ),
            ],
          )),
    );
  }
}
