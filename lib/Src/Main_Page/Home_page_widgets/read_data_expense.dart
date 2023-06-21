import 'dart:developer';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IncomeData extends StatefulWidget {
  const IncomeData({super.key});

  @override
  State<IncomeData> createState() => _IncomeDataState();
}

class _IncomeDataState extends State<IncomeData> {
  final user = FirebaseAuth.instance.currentUser!;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference data = FirebaseFirestore.instance.collection('users');

  // Future<void> updateUser() {
  //   return data
  //       .doc("tomtom@gmail.com")
  //       .update({"name": []})
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc("tomtom@gmail.com")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator.adaptive();
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          log(data["incomes"].toString());
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data["incomes"].length,
            itemBuilder: (context, index) {
              var p = data["incomes"][index];
              return Slidable(
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: "Delete",
                    ),
                  ],
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p["name"].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        p["amount"].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  subtitle: Text(p["date"].toString()),
                ),
              );
            },
          );
        }
      },
    );
  }
}
