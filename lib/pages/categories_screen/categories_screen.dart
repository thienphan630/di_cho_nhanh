import 'package:flutter/material.dart';

import '../../widgets/data.dart';
import '../../widgets/search_appbar.dart';
import 'widgets/categorise_widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEF),
      body: Stack(children: [
        Positioned(
            top: -size.height / 1.3,
            left: -size.width / 2,
            child: Container(
              width: size.width * 2,
              height: size.width * 2,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF84CBFF)),
            )),
        Scaffold(
          appBar: appBarSearch(),
          backgroundColor: Colors.transparent,
          body: Column(children: [
            const BannerCategories(),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topic('Cá'),
                    abc(),
                    _topic('Thịt'),
                    abc(),
                    _topic('Rau'),
                    abc(),
                  ],
                ),
              ),
            )
            // Item(
            //   name: 'Cá Tầm',
            //   onTap: () {},
            //   price: 253000,
            // ),
          ]),
        )
      ]),
    );
  }
}

Widget _topic(String topic) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 4.0),
    child: Text(
      topic,
      style: const TextStyle(
          fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );
}

Widget abc() {
  return SizedBox(
    height: 160,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Item(
            name: products[index]['name'].toString(),
            price: products[index]['price'] as double,
            onTap: () {},
          );
        }),
  );
}
