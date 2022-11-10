import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item_favorite.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var query = db
        .collection('users')
        .doc('9AxMMbQDQetVKbp9kuWA')
        .collection('favorite')
        .snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: query,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            log(snapshot.data!.docs.first.data().toString());
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3),
                    itemBuilder: (context, index) {
                      var query1 = snapshot.data!.docs[index];
                      return favoriteItem(
                        query1.get('name'),
                        query1.get('image'),
                        query1.get('price'),
                      );
                    },
                  )
                : const Center(child: Text('No data'));
          }
        });
  }
}
