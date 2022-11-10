import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_widgets.dart';

class CategoriesCardList extends StatefulWidget {
  const CategoriesCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesCardList> createState() => _CategoriesCardListState();
}

class _CategoriesCardListState extends State<CategoriesCardList> {
  var db = FirebaseFirestore.instance;
  Map<String, dynamic>? categories = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('Categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.hasData
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return CategoriesCartItem(
                        name: snapshot.data!.docs[index].get('name'),
                        imageURL: snapshot.data!.docs[index].get('image'),
                        onTap: () {},
                      );
                    })
                : const Center(child: Text('No data'));
          }
        });
  }
}
