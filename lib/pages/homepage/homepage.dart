import 'package:flutter/material.dart';

import '../../constraints/constraints.dart';
import 'widget/home_widgets.dart';
import 'widget/search_container.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kBackgroundColor,
            actions: const [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/cat.jpg"),
              ),
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Tường',
                    style: TextStyle(
                        color: kBlackColor,
                        height: 0.7,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                Text('Xin chào!',
                    style: TextStyle(
                        color: kBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400))
              ],
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SearchContainer(),
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
