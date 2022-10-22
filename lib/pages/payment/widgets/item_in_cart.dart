import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';

class ItemInCart extends StatefulWidget {
  const ItemInCart({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);
  final String name;
  final double price;
  final double quantity;

  @override
  State<ItemInCart> createState() => _ItemInCartState();
}

class _ItemInCartState extends State<ItemInCart> {
  double _quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 150,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color(0xFF84CBFF),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: const CircleAvatar(
                maxRadius: 42,
                backgroundImage: AssetImage('assets/images/meat.png')),
          ),
          Container(
            width: 200,
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text('${widget.price} đ/Kg',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            _quantity -= 0.1;
                          });
                        }),
                        child: const Text(
                          '-',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        _quantity.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _quantity += 0.1;
                          });
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
