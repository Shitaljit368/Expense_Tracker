import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../Constant/colors.dart';

class ReadIcomeDataPage extends StatefulWidget {
  const ReadIcomeDataPage({super.key});

  @override
  State<ReadIcomeDataPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReadIcomeDataPage> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');
  // Future<void> updateUser(List<dynamic> udata) {

  //   return firestore
  //       .doc("Shhhital@gmail.com")
  //       .update(
  //         {
  //           "incomes": udata,
  //         },
  //       )
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc("test@gmail.com")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator.adaptive();
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        var d = data["incomes"] as List;
        log("test $d");

        return ListView.builder(
          shrinkWrap: true,
          itemCount: d.length,
          itemBuilder: (context, i) {
            return Card(
              margin: const EdgeInsets.only(bottom: 2),
              color: Theme.of(context).colorScheme.primary,
              child: Slidable(
                // child: const ListTile(title: Text('Slide me')),
                startActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          incomeController.text = d[i]["name"];
                          amountController.text = d[i]["amount"];
                          dateInputController.text = d[i]["date"];
                          imageController.text = d[i]["image"];
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
                                  right: 40,
                                  left: 40,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
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
                                      "Edit income item",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
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
                                    readOnly: true,
                                    controller: dateInputController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Date",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.calendar_today,
                                        ),
                                        prefixIconColor: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  TextFormField(
                                    controller: incomeController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500]),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: amountController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: 'Amount',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500]),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: imageController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: 'image',
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
                                          onPressed: () async {
                                            d[i]["name"] =
                                                incomeController.text;
                                            d[i]["amount"] =
                                                amountController.text;
                                            d[i]["date"] =
                                                dateInputController.text;
                                            d[i]["image"] =
                                                imageController.text;
                                            var f = data["incomes"] as List;
                                            var m = f
                                                .map((e) =>
                                                    e as Map<String, dynamic>)
                                                .toList();
                                                

                                            DocumentReference
                                                documentReference =
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc("test@gmail.com");

                                            await documentReference
                                                .update({"incomes": m});
                                            print("sycess$data");
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
