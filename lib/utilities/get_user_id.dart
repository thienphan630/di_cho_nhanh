import 'package:firebase_auth/firebase_auth.dart';

String getUserId() {
  if (FirebaseAuth.instance.currentUser != null) {
    return FirebaseAuth.instance.currentUser!.uid;
  }
  return '';
}
