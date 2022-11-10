import 'package:flutter/material.dart';

import 'home_widgets.dart';

class TopSearch extends StatelessWidget {
  const TopSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var db = FirebaseFirestore.instance;
    // var query = db
    //     .collection('users')
    //     .doc('9AxMMbQDQetVKbp9kuWA')
    //     .collection('favorite');

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (_, index) {
        return TopSearchItem(
          name: products[index]['name'].toString(),
          onTap: () {},
          onFavoriteTap: () {
            // query.add(FavoriteModel(
            //         name: 'Cá Ngừ',
            //         image: '1AAEdlNzGV7ZGfVOYp68z4FFKsETbocRV',
            //         price: 222)
            //     .toMap());
          },
        );
      },
    );
  }
}
