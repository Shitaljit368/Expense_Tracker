import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              itemCount: f.length,
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                                    "💰",
                                    style: TextStyle(fontSize: 26),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              f[i]["name"].toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "+${f[i]["amount"]}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
