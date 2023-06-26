import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../Constant/colors.dart';

class ReadExpenseDataPage extends StatefulWidget {
  const ReadExpenseDataPage({super.key});

  @override
  State<ReadExpenseDataPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReadExpenseDataPage> {
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  // TextEditingController imageController = TextEditingController();
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(user.email)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator.adaptive();
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        var d = data["expenses"] as List;
        log("test $d");

        return ListView.builder(
          shrinkWrap: true,
          itemCount: d.length,
          itemBuilder: (context, i) {
            return Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white24))),
              child: Slidable(
                // child: const ListTile(title: Text('Slide me')),
                startActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          remarkController.text = d[i]["name"];
                          amountController.text = d[i]["amount"];
                          dateInputController.text = d[i]["date"];
                          // imageController.text = d[i]["image"];
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  top: 0,
                                  right: 25,
                                  left: 25,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 5,
                                          width: 70,
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
                                        "Create a new income item",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1990),
                                                lastDate: DateTime(2050),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          ColorScheme.light(
                                                        primary: Colors.teal,
                                                        onPrimary: Colors.white,
                                                        onSurface: Theme.of(
                                                                context)
                                                            .colorScheme
                                                            .primaryContainer,
                                                      ),
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor: Theme
                                                                  .of(context)
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
                                            style:
                                                const TextStyle(fontSize: 16),
                                            readOnly: true,
                                            controller: dateInputController,
                                            decoration: const InputDecoration(
                                                hintText: "Date",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                prefixIcon: Icon(
                                                  Icons.calendar_today,
                                                ),
                                                prefixIconColor: Colors.grey),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 155,
                                          child: TextFormField(
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                            style:
                                                const TextStyle(fontSize: 18),
                                            decoration: InputDecoration(
                                              hintText: 'Amount',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[500]),
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
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
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
                                          width: 160,
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
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                newHexGreen,
                                              ),
                                            ),
                                            onPressed: () async{
                                              d[i]["name"] =
                                                remarkController.text;
                                            d[i]["amount"] =
                                                amountController.text;
                                            d[i]["date"] =
                                                dateInputController.text;
                                            // d[i]["image"] =
                                            //     imageController.text;
                                            var listReceiver =
                                                data["incomes"] as List;
                                            var uploadAsList = listReceiver
                                                .map((e) =>
                                                    e as Map<String, dynamic>)
                                                .toList();

                                            DocumentReference
                                                documentReference =
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(user.email);

                                            await documentReference.update({
                                              "incomes": uploadAsList
                                            }).whenComplete(() {
                                              Navigator.pop(context);
                                              
                                              return EasyLoading.showSuccess(
                                                  "updated");
                                            });
                                            // print("success $data");
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
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ]),
                endActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const BehindMotion(),
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
                  focusColor: Colors.white24,
                  splashColor: Colors.white,
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "🚘",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  onTap: () {
                    log(d[i].toString());
                    log(data.toString());
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        d[i]["name"].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        d[i]["amount"].toString(),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    d[i]["date"].toString(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
