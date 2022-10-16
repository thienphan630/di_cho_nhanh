import 'package:flutter/material.dart';

class TopSearchItem extends StatefulWidget {
  const TopSearchItem({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);
  final String name;
  final VoidCallback onTap;

  @override
  State<TopSearchItem> createState() => _TopSearchItemState();
}

class _TopSearchItemState extends State<TopSearchItem> {
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            width: 120,
            height: 110,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(132, 203, 255, 0.8),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color.fromRGBO(0, 0, 0, 0.25))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: const [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          '5.0',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ]),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.white,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const CircleAvatar(
            maxRadius: 40,
            backgroundImage: AssetImage('assets/images/meat.png'),
          )
        ],
      ),
    );
  }
}
