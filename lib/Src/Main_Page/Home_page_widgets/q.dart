import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../Constant/colors.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  
  TextEditingController incomeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
   Future<dynamic> quickAdd(BuildContext context) {
    return showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                backgroundColor: greyThree,
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
                                child: const Text("Cancel"),
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