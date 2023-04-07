import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/config/route_path.dart';
import 'package:di_cho_nhanh/models/agruments/product_agrument.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:flutter/material.dart';

import 'home_widgets.dart';

class TopSearch extends StatelessWidget {
  const TopSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = getUserId();
    CollectionReference<Map<String, dynamic>> favorites = FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('favorites');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: favorites.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.size,
              itemBuilder: (_, index) {
                var data = snapshot.data!.docs[index];
                return TopSearchItem(
                  // name: products[index]['name'].toString(),
                  name: data.get('name'),
                  imageURL: data.get('image'),
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.product,
                        arguments: ProductAgrument(data.get('id')));
                  },
                  onFavoriteTap: () {},
                );
              },
            );
          } else {
            return Container();
          }
        }
      },
    );
    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: products.length,
    //   itemBuilder: (_, index) {
    //     return TopSearchItem(
    //       name: products[index]['name'].toString(),
    //       onTap: () {},
    //       onFavoriteTap: () {
    //         // query.add(FavoriteModel(
    //         //         name: 'Cá Ngừ',
    //         //         image: '1AAEdlNzGV7ZGfVOYp68z4FFKsETbocRV',
    //         //         price: 222)
    //         //     .toMap());
    //       },
    //     );
    //   },
    // );
  }
}
