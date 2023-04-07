import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/route_path.dart';
import '../../../models/agruments/auth_agrument.dart';
import '../../../providers/auth_provider.dart';
import '../../../utilities/get_user_id.dart';

class Personal extends StatelessWidget {
  const Personal({super.key});

  @override
  Widget build(BuildContext context) {
    Role role = Provider.of<AuthProvider>(context, listen: false).getRole;

    DocumentReference<Map<String, dynamic>> userInfor = getUserInfor(role);

    return SafeArea(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userInfor.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.get('firstName') +
                            ' ' +
                            snapshot.data!.get('lastName'),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        snapshot.data!.get('email'),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Số điện thoại: ${snapshot.data!.get('phoneNumber')}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 2),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      role == Role.seller
                          ? Text(
                              'Tên cửa hàng: ${snapshot.data!.get('storeName')}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          : const SizedBox(),
                      role == Role.seller
                          ? const SizedBox(height: 8)
                          : const SizedBox(),
                      Text(
                        'Địa chỉ: ${snapshot.data!.get('address')}',
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 2),
                role == Role.buyer
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.ordersHistory);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 52, vertical: 12),
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.history),
                              SizedBox(width: 12),
                              Text(
                                'Lịch sử đặt hàng',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.editInf);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 52, vertical: 12),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.change_circle),
                        SizedBox(width: 12),
                        Text(
                          'Chỉnh sửa thông tin',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      _signOut();
                      deleteUser();
                      Navigator.pushNamed(context, RoutePath.auth);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text('Đăng xuất', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    // return ElevatedButton(
    //   onPressed: () {
    //     _signOut();
    //     deleteUser();
    //     Navigator.pushNamed(context, RoutePath.auth);
    //   },
    //   child: const Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    //     child: Text('Đăng xuất', style: TextStyle(fontSize: 16)),
    //   ),
    // );
  }
}

/// Sign out firebase authentication
Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
