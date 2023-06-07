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
  TextEditingController incomeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                              Container(
                                height: 5,
                                width: 100,
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
                          const SizedBox(height: 20.0),
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
                                lastDate: DateTime(2050),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  dateInputController.text = formattedDate;
                                });
                              } else {}
                            },
                            readOnly: true,
                            controller: dateInputController,
                            decoration: const InputDecoration(
                                hintText: "Enter Date",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                ),
                                prefixIconColor: Colors.grey),
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
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'Name',
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
                                    backgroundColor: MaterialStatePropertyAll(
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
        title: const Text("My Incomes"),
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
        ],
      ),
    );
  }
}
