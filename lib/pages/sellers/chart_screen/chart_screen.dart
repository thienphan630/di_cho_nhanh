import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:di_cho_nhanh/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  var orders = FirebaseFirestore.instance
      .collection('order_history')
      .where('sellerId', isEqualTo: getUserId());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          titleAppBar(context: context, title: 'Người đã mua hàng'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var users = FirebaseFirestore.instance
                    .collection('users')
                    .doc(data.get('buyerId'));
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: users.snapshots(),
                  builder: (context, subSnapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (subSnapshot.hasData) {
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(
                                '${subSnapshot.data!.get('firstName')} ${subSnapshot.data!.get('lastName')}'),
                            trailing: Text('${data.get('time')}'),
                          ),
                          const Divider()
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Chưa có người mua hàng'),
            );
          }
        },
      ),
    );
  }
  // body: Padding(
  //   padding: const EdgeInsets.all(32.0),
  //   child: PieChart(
  //     PieChartData(sections: [
  //       PieChartSectionData(
  //           value: 10, color: Colors.red, radius: 64, title: 'Red'),
  //       PieChartSectionData(
  //           value: 02, color: Colors.red, radius: 64, title: 'Red'),
  //       PieChartSectionData(
  //           value: 10, color: Colors.red, radius: 64, title: 'Red'),
  //     ]),
  //     swapAnimationDuration: const Duration(milliseconds: 150), // Optional
  //     swapAnimationCurve: Curves.linear,
  //   ),
  // ),

}
