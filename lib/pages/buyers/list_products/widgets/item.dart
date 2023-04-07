import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../constraints/styles.dart';

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.name,
      required this.imageURL,
      required this.price,
      required this.onTap,
      required this.onBuyTap});
  final String name;
  final String imageURL;
  final num price;
  final VoidCallback onTap;
  final VoidCallback onBuyTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: const BoxDecoration(
          color: Color(0xFF84CBFF),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: Image.memory(
              base64Decode(imageURL),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '$price đ/Kg',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              GestureDetector(
                onTap: onBuyTap,
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Color(0xFF58A700),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

// Widget favoriteItem(String name, String imageURL, num price, VoidCallback onTap,
//     VoidCallback onBuyTap) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       height: 200,
//       margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
//       padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
//       decoration: const BoxDecoration(
//         color: Color(0xFF84CBFF),
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//       ),
//       child:
//           Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//         CircleAvatar(
//             maxRadius: 50,
//             backgroundImage: NetworkImage(
//                 'https://drive.google.com/uc?export=view&id=$imageURL')),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 Text(
//                   '$price đ/Kg',
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400),
//                 )
//               ],
//             ),
//             GestureDetector(
//               onTap: onBuyTap,
//               child: const Icon(
//                 Icons.shopping_cart_rounded,
//                 color: Color(0xFF58A700),
//               ),
//             )
//           ],
//         ),
//       ]),
//     ),
//   );
// }
