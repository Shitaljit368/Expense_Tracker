import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditIncomeData extends StatefulWidget {
  const EditIncomeData({super.key});

  @override
  State<EditIncomeData> createState() => _EditIncomeDataState();
}

class _EditIncomeDataState extends State<EditIncomeData> {
  CollectionReference data = FirebaseFirestore.instance.collection('users');
  Future<void> updateUser() {
    return data
        .doc("tomtom@gmail.com")
        .update({"name": "Name change success"})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator.adaptive();
        } else {
          List<Map<String, dynamic>> myDatas = snapshot.data!.docs.map((e) {
            // logger.e(e.id);
            return e.data();
          }).toList();
          return ListView.builder(
            itemCount: myDatas.length,
            itemBuilder: (context, i) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: myDatas[i]["incomes"].length,
                itemBuilder: (context, j) {
                  var p = myDatas[i]["incomes"][j];
                  return ListTile(
                    onTap: () {
                      // logger.d(p[j]["label"].toString());
                      updateUser();
                      // data.doc("tomtom@gmail.com").update({"name": "Momo"});
                    },
                    title: Row(
                      children: [
                        Text(p["name"]),
                        Text(p["amount"].toString()),
                      ],
                    ),
                    subtitle: Image.network(p["date"]),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
