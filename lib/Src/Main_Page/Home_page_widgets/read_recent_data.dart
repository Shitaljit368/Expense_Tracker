import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReadRecentDataPage extends StatefulWidget {
  const ReadRecentDataPage({
    super.key,
  });

  @override
  State<ReadRecentDataPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReadRecentDataPage> {

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
          var f = d?["recent_activities"] as List;

          log(d.toString());

          if (d == null || d["recent_activities"].length == 0) {
            return SizedBox(
              height: 650,
              width: double.infinity,
              child: Image.asset("assests/images/empty1.png"),
            );
          } else {
            return ListView.builder(
              // shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: f.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Slidable(
                      endActionPane: ActionPane(
                          extentRatio: 0.3,
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                var listReceiver =
                                    d["recent_activities"] as List;

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
                                  "recent_activities": uploadAsList
                                }).whenComplete(() {
                                  return EasyLoading.showSuccess("deleted");
                                });
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ]),
                      child: ListTile(
                        horizontalTitleGap: 20,
                        leading: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            // borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "R",
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
                                "${f[i]["amount"]}",
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
                    
                  ],
                );
              },
            );
          }
        } else {
          return const SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
