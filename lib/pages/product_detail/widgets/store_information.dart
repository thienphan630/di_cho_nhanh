import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';

class StoreInformation extends StatelessWidget {
  const StoreInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('DoraMart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text('Online 5 phút trước',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12)),
                Text('Hà Nội',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
