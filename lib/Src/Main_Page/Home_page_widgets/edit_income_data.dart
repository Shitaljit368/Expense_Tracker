import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditIncomeData extends StatefulWidget {
  final TextEditingController newIncomeController;
  final TextEditingController newAmountController;
  final TextEditingController newDateInputController;
  final TextEditingController newImageController;
  const EditIncomeData(
      {super.key,
      required this.newIncomeController,
      required this.newAmountController,
      required this.newDateInputController,
      required this.newImageController});

  @override
  State<EditIncomeData> createState() => _EditIncomeDataState();
}

class _EditIncomeDataState extends State<EditIncomeData> {
  CollectionReference data = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc("Shhhital@gmail.com")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator.adaptive();
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          var d = data["incomes"] as List;

          return ListView.builder(
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  // editDetails() {
                  // d[i]["name"] = newIncomeController;
                  //   d[i]["amount"] = amountController;
                  //   d[i]["date"] = dateController;
                  //   d[i]["image"] = imageController;
                  // }  
                },
              );
            },
          );
        }
      },
    );
  }
}
