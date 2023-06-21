import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../Constant/colors.dart';

class MySavingsListPage extends StatefulWidget {
  const MySavingsListPage({super.key});

  @override
  State<MySavingsListPage> createState() => _MySavingsListPageState();
}

class _MySavingsListPageState extends State<MySavingsListPage> {
  TextEditingController futureController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  @override
  void initState() {
    dateInputController.text = ""; //set the initial value of text field
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
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
                              "Create a new future plan",
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
                            controller: futureController,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'New plan',
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
                                      HexColor("#009E60"),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                    } else {
                                      EasyLoading.showError(
                                          "Please fill the form");
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
        title: const Text("My Future plans"),
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
          ElevatedButton(onPressed: () {
            context.router.push( const GetStartedRoute());
          }, child: const Text("On Boarding"))
        ],
      ),
    );
  }
}
