import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IncomeData extends StatefulWidget {
  const IncomeData({super.key});

  @override
  State<IncomeData> createState() => _IncomeDataState();
}

class _IncomeDataState extends State<IncomeData> {
  CollectionReference data = FirebaseFirestore.instance.collection('users');
  Future<void> updateUser() {
    return data
        .doc("tomtom@gmail.com")
        .update({"name": [
            
        ]})
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
            return e.data();
          }).toList();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: myDatas.length,
            itemBuilder: (context, i) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: myDatas[i]["incomes"].length,
                itemBuilder: (context, j) {
                  var p = myDatas[i]["incomes"][j];
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        label: "Delete",
                        onPressed: (context) {},
                        icon: Icons.delete,
                      )
                    ]),
                    startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        // dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            label: "Edit",
                            backgroundColor: Colors.green,
                            onPressed: (context) {
                              updateUser();
                              // const SnackBar(
                              //   content: Text("Edit data?"),
                              // );
                            },
                            icon: Icons.edit,
                          )
                        ]),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
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
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(p["name"].toString()),
                          Text(p["amount"].toString()),
                        ],
                      ),
                      subtitle: Text(p["date"].toString()),
                      // trailing: Text(p["amount"].toString()),
                    ),
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
