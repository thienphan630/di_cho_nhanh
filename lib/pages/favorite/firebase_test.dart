import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firebase extends StatefulWidget {
  const Firebase({Key? key}) : super(key: key);

  @override
  State<Firebase> createState() => _FirebaseState();
}

class _FirebaseState extends State<Firebase> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          try {
            await db.collection("users").get().then((event) {
              for (var doc in event.docs) {
                log("${doc.id} => ${doc.data()}");
              }
            });
            log('get successful');
          } catch (e) {
            log('$e');
          }
        },
        child: const Text('Set data'),
      )),
    );
  }
}
