import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    Key? key,
    required this.addToCartTap,
    required this.buyNowTap,
  }) : super(key: key);
  final VoidCallback addToCartTap;
  final VoidCallback buyNowTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: addToCartTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.only(bottom: 12),
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Color(0x40000000))
              ]),
              child: const Center(
                child: Text(
                  'Thêm vào giỏ hàng',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
