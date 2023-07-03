import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../Constant/colors.dart';

class ReadIcomeDataPage extends StatefulWidget {
  const ReadIcomeDataPage({
    super.key,
  });

  @override
  State<ReadIcomeDataPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReadIcomeDataPage> {
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  // TextEditingController imageController = TextEditingController();
  // CollectionReference firestore =
  //     FirebaseFirestore.instance.collection('users');
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
        if (snapshot.hasData) {
          var d = snapshot.data?.data();
          var f = d?["incomes"] as List;

          log(d.toString());

          if (d == null || d["incomes"].length == 0) {
            return SizedBox(
              height: 650,
              width: double.infinity,
              child: Image.asset("assests/images/empty1.png"),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: f.length,
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                  child: Slidable(
                    startActionPane: ActionPane(
                        extentRatio: 0.3,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              remarkController.text = f[i]["name"];
                              log(f[i]["name"].toString());
                              amountController.text = f[i]["amount"];
                              log(f[i]["amount"].toString());
                              dateInputController.text = f[i]["date"];
                              log(f[i]["date"].toString());
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
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Form(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      BorderRadius.circular(
                                                          20)),
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
                                                            primary:
                                                                Colors.teal,
                                                            onPrimary:
                                                                Colors.white,
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
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                readOnly: true,
                                                controller: dateInputController,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "Date",
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        prefixIcon: Icon(
                                                          Icons.calendar_today,
                                                        ),
                                                        prefixIconColor:
                                                            Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 155,
                                              child: TextFormField(
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                controller: amountController,
                                                style: const TextStyle(
                                                    fontSize: 18),
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      splashFactory: InkSparkle
                                                          .constantTurbulenceSeedSplashFactory,
                                                      overlayColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.grey
                                                                  .shade100)),
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
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                              height: 50,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Colors.tealAccent,
                                                        Colors.deepPurple,
                                                      ]),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: const Offset(
                                                            10, 10),
                                                        blurRadius: 30,
                                                        color: Colors.black
                                                            .withOpacity(0.15))
                                                  ]),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    foregroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                onPressed: () async {
                                                  f[i]["name"] =
                                                      remarkController.text;

                                                  f[i]["amount"] =
                                                      amountController.text;
                                                  log(f[i]["amount"]
                                                      .toString());
                                                  f[i]["date"] =
                                                      dateInputController.text;

                                                  var listReceiver =
                                                      d["incomes"] as List;
                                                  var uploadAsList =
                                                      listReceiver
                                                          .map((e) => e as Map<
                                                              String, dynamic>)
                                                          .toList();

                                                  DocumentReference
                                                      documentReference =
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(user.email);

                                                  await documentReference
                                                      .update({
                                                    "incomes": uploadAsList
                                                  }).whenComplete(() {
                                                    Navigator.pop(context);
                                                    return EasyLoading
                                                        .showSuccess("updated");
                                                  });
                                                  // print("success $data");
                                                },
                                                child: const Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 20),
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
                            onPressed: (context) async {
                              // var d = snapshot.data?.data();
                              // var f = d?["incomes"] as List;

                              var listReceiver = d["incomes"] as List;

                              log(listReceiver[i].toString());

                              listReceiver.removeAt(
                                  listReceiver.indexOf(listReceiver[i]));
                              log(d.toString());
                              var uploadAsList = listReceiver
                                  .map((e) => e as Map<String, dynamic>)
                                  .toList();
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user.email)
                                  .update({
                                "incomes": uploadAsList
                              }).whenComplete(() {
                                return EasyLoading.showSuccess("deleted");
                              });

                              // await documentReference.update(
                              //     {"incomes": uploadAsList}).whenComplete(() {
                              //   Navigator.pop(context);
                              //   return EasyLoading.showSuccess("deleted");
                              // });
                              // print("success $data");

                              // HapticFeedback.lightImpact();
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                    child: ListTile(
                      horizontalTitleGap: 20,
                      // focusColor: Colors.teal,
                      // splashColor: Colors.grey.withOpacity(0.1),

                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color:Colors.amberAccent,
                              // Theme.of(context).colorScheme.secondaryContainer,
                          // borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "I",
                              style: TextStyle(fontSize: 26),
                            ),
                          ],
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      onTap: () {
                        log(d[i].toString());
                        log(f[i]["name"].toString());
                        log(f[i]["amount"].toString());
                        log(f[i]["date"].toString());
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              f[i]["name"].toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "+${f[i]["amount"]}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        f[i]["date"].toString(),
                        style:
                            const TextStyle(color: Colors.teal, fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
