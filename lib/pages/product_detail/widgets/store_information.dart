import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';

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
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.all(kDefaultPadding),
              child: const Text(
                'logo',
              )),
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: storeInf.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.get('storeName')}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        const Text('Online 5 phút trước',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        Text('${data.get('address')}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                      ],
                    );
                  } else {
                    return const Text('No data');
                  }
                }),
          )
        ],
      ),
    );
  }
}
