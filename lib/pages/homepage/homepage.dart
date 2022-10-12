import 'package:flutter/material.dart';

import '../../constraints/index.dart';
import 'widget/banner.dart';
import 'widget/search_container.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kBackgroundColor,
            leading: const Icon(
              Icons.reorder,
              color: kBlackColor,
              size: 28,
            ),
            actions: const [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/cat.jpg"),
              ),
              // Container(
              //   margin: const EdgeInsets.only(right: kDefaultPadding),
              //   width: 42,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.fitWidth,
              //           image: AssetImage('assets/images/cat.jpg')),
              //       borderRadius: BorderRadius.all(Radius.circular(50))),
              // )
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
                  fit: FlexFit.loose,
                  child: BannerCustom(),
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Danh mục',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 110,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(132, 203, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color: Color.fromRGBO(0, 0, 0, 0.25))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              CircleAvatar(minRadius: 40),
                              Text(
                                'Thịt',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )
                      ],
                    )
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
