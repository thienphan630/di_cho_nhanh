import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/styles.dart';

class Delivery extends StatelessWidget {
  const Delivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance.collection('users').doc(getUserId());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
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
          const Text(
            'Vận chuyển tới: ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: users.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Text(
                    '${snapshot.data!.get('address')}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                     ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
          )
        ],
      ),
    );
  }
}
