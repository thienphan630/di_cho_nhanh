import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/constraints.dart';
import '../../../../models/agruments/product_agrument.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Query<Map<String, dynamic>> products = FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        // ignore: prefer_interpolation_to_compose_strings
        .where('name', isLessThanOrEqualTo: searchQuery + "\uf8ff");

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 2 * kDefaultPadding, vertical: kDefaultPadding),
                width: double.infinity,
                height: 44,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4.0,
                          offset: Offset(0, 4),
                          color: Color.fromRGBO(0, 0, 0, 0.25))
                    ]),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Tìm kiếm',
                        ),
                        autofocus: true,
                        onChanged: (query) => updateSearchQuery(query),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: products.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot<Map<String, dynamic>> data =
                              snapshot.data!.docs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/product',
                                  arguments: ProductAgrument(data.id));
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.memory(
                                  base64Decode(data.get('image')),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text('${data.get('name')}'),
                              trailing: Text('${data.get('price')} vnd'),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('No data');
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }
}
