import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/config/route_path.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constraints/constraints.dart';
import '../../models/agruments/auth_agrument.dart';
import '../../providers/auth_provider.dart';
import 'widget/home_widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Role role = Provider.of<AuthProvider>(context, listen: false).getRole;
    DocumentReference<Map<String, dynamic>> userInfor = getUserInfor(role);
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
            title: const TitleUserInfor(
              name: 'Tường',
            )),
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
                    const SizedBox(height: 130, child: CategoriesCardList()),
                    _topic('Tìm kiếm hàng đầu'),
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
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: const TextStyle(
                color: kBlackColor,
                height: 0.7,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        const Text('Xin chào!',
            style: TextStyle(
                color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w400))
      ],
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
