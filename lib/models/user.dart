// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class User with ChangeNotifier {
//   String id;
//   String displayName;
//   String photoURL;
//   String email;

//   User({
//     required this.id,
//     required this.displayName,
//     required this.photoURL,
//     required this.email,
//   });

//   factory User.fromFirestore(DocumentSnapshot userDoc) {
//     Map userData = userDoc.data;
//     return User(
//       id: userData.documentID,
//       displayName: userData['displayName'],
//       photoURL: userData['photoURL'],
//       email: userData['email'],
//     );
//   }
// }
