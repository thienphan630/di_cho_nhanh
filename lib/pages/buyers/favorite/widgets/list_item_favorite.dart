import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:flutter/material.dart';

import 'item_favorite.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = getUserId();
    CollectionReference<Map<String, dynamic>> favorite = FirebaseFirestore
        .instance
        .collection('users')
        .doc(id)
        .collection('favorite');

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: favorite.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // log(snapshot.data!.docs.first.data().toString());
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3),
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> data =
                          snapshot.data!.docs[index];
                      return favoriteItem(
                        data.get('name'),
                        data.get('image'),
                        data.get('price'),
                      );
                    },
                  )
                : const Center(child: Text('No data'));
          }
        });
  }
}
