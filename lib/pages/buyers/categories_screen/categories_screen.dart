import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/widgets/app_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/categories_widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories = FirebaseFirestore.instance
        .collection('Categories')
        .where('numberOfItems', isGreaterThan: 0);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEF),
      body: Stack(children: [
        Positioned(
            top: -size.height / 1.5,
            left: -size.width / 2,
            child: Container(
              width: size.width * 2,
              height: size.width * 2,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF84CBFF)),
            )),
        Scaffold(
          appBar: titleAppBar(context: context, title: 'Danh mục sản phẩm'),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const BannerCategories(),
              Flexible(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: categories.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot<Map<String, dynamic>> data =
                                  snapshot.data!.docs[index];
                              String type = data.get('type');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  categoriesName(data.get('name')),
                                  listProducts(type),
                                ],
                              );
                            },
                          )
                        : const Center(child: Text('No data'));
                  }
                },
              )),
            ],
          ),
        )
      ]),
    );
  }
}

Widget categoriesName(String topic) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 4.0),
    child: Text(
      topic,
      style: const TextStyle(
          fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );
}
