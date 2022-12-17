import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/agruments/auth_agrument.dart';

String getUserId() {
  if (FirebaseAuth.instance.currentUser != null) {
    return FirebaseAuth.instance.currentUser!.uid;
  }
  return '';
}

DocumentReference<Map<String, dynamic>> getUserInfor(Role role) {
  String collectionQuery = role == Role.buyer ? 'users' : 'sellers';
  return FirebaseFirestore.instance
      .collection(collectionQuery)
      .doc(getUserId());
}
