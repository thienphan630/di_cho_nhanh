import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/functions/auth_func.dart';
import 'package:di_cho_nhanh/pages/Shared/personal_screen/widgets/setting_page_button.dart';
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
                    ? SettingPageButton(
                        title: 'Lịch sử đặt hàng',
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.ordersHistory);
                        },
                        icon: const Icon(Icons.history))
                    : const SizedBox(),
                SettingPageButton(
                  title: 'Chỉnh sửa thông tin',
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.editInf);
                  },
                  icon: const Icon(Icons.change_circle),
                ),
                const Spacer(),
                SettingPageButton(
                    title: 'Đăng xuất',
                    onTap: () {
                      signOut();
                      deleteUser();
                      Navigator.pushNamed(context, RoutePath.auth);
                    },
                    icon: const Icon(Icons.logout))
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
