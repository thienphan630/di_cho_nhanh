import 'package:flutter/material.dart';

import '../../../constraints/index.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
      width: double.infinity,
      // width: 100,
      height: 44,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 4.0,
                offset: Offset(0, 4),
                color: Color.fromRGBO(0, 0, 0, 0.25))
          ]),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration.collapsed(
                hintText: 'Tìm kiếm',
              ),
            ),
          )
        ],
      ),
    );
  }
}
