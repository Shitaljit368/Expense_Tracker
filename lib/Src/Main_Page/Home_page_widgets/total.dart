// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class TotalAmountPage extends StatefulWidget {
//   const TotalAmountPage({super.key});

//   @override
//   State<TotalAmountPage> createState() => _TotalAmountPageState();
// }

// class _TotalAmountPageState extends State<TotalAmountPage> {
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection("users")
//           .doc(user.email)
//           .snapshots(),
//       builder: (context,
//           AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//             if(snapshot.hasData){
//               var d = snapshot.data?.data();

//             }
//           },
//     );
//   }
// }
