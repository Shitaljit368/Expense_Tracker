import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exptracker/Constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReadFutureOnHome extends StatefulWidget {
  const ReadFutureOnHome({
    super.key,
  });

  @override
  State<ReadFutureOnHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReadFutureOnHome> {
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
          var f = d?["future_plans"] as List;

          log(d.toString());

          if (d == null || d["future_plans"].length == 0) {
            return SizedBox(
              height: 650,
              width: double.infinity,
              child: Image.asset("assests/images/empty1.png"),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  height: 220,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.amber
                                  // Theme.of(context)
                                  //     .colorScheme
                                  //     .secondaryContainer,
                                  // borderRadius: BorderRadius.circular(10)
                                  ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "P",
                                    style:
                                        TextStyle(fontSize: 26, color: white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FittedBox(
                              child: Text(
                                f[i]["name"].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.currency_rupee,
                                    color: grey,
                                  ),
                                  Text(
                                    "${f[i]["amount"]}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                var listReceiver = d["future_plans"] as List;

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
                                  "future_plans": uploadAsList
                                }).whenComplete(() {
                                  return EasyLoading.showSuccess("deleted");
                                });
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: grey,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return Center(
            child: SizedBox(
              height: 1,
              width: 1,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: opBlack,
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation(
                  Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
