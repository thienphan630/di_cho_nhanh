import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/styles.dart';

class StoreInformation extends StatelessWidget {
  const StoreInformation({
    Key? key,
    required this.document,
  }) : super(key: key);
  final String document;
  @override
  Widget build(BuildContext context) {
    var storeInf =
        FirebaseFirestore.instance.collection('sellers').doc(document);

    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          color: Color(0x40000000),
        )
      ]),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: storeInf.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.all(kDefaultPadding),
                      decoration: const BoxDecoration(
                          color: Colors.blueGrey, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          data.get('storeName').toString().substring(0, 1),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${data.get('storeName')}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('${data.get('address')}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12)),
                    ],
                  ))
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
