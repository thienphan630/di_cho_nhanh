import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/config/route_path.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constraints/constraints.dart';
import '../../../models/agruments/auth_agrument.dart';
import '../../../providers/auth_provider.dart';
import 'widget/home_widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: kBackgroundColor,
            actions: const [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/cat.jpg"),
              ),
            ],
            title: const TitleUserInfor()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.searchScreen);
                    },
                    icon: const Icon(Icons.manage_search_rounded),
                    label: const Text('Tìm kiếm'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    )),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                const SizedBox(height: kDefaultPadding),
                const Flexible(
                  child: BannerCustom(),
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topic('Danh mục'),
                    const SizedBox(height: 150, child: CategoriesCardList()),
                    _topic('Sản phẩm ưa thích'),
                    const SizedBox(height: 200, child: TopSearch())
                  ],
                ))
              ],
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
    );
  }
}

class TitleUserInfor extends StatelessWidget {
  const TitleUserInfor({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Role role = Provider.of<AuthProvider>(context, listen: false).getRole;
    DocumentReference<Map<String, dynamic>> userInfor = getUserInfor(role);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userInfor.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Xin chào!',
                    style: TextStyle(
                        color: kBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                Text(
                    snapshot.data!.get('firstName') +
                        ' ' +
                        snapshot.data!.get('lastName'),
                    style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ],
            );
          } else {
            return const Text('...');
          }
        });
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
