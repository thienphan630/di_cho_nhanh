import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/constraints/styles.dart';
import 'package:di_cho_nhanh/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> products =
        FirebaseFirestore.instance.collection('products').doc(id);

    return Scaffold(
      appBar: titleAppBar('Chi tiết sản phẩm'),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Map<String, dynamic>? data = snapshot.data!.data();
            return ProductDetailContent(
              name: data!['name'],
              price: data['price'],
              sold: data['sold'],
              imageURL: data['image'],
              stars: data['stars'],
            );
          }
        },
      ),
    );
  }
}

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    Key? key,
    required this.name,
    required this.price,
    required this.sold,
    required this.imageURL,
    required this.stars,
  }) : super(key: key);
  final String name;
  final num price;
  final num sold;
  final String imageURL;
  final num stars;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Image.network(
              'https://drive.google.com/uc?export=view&id=$imageURL'),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: kDefaultPadding),
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Color(0x40000000),
            )
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text('đ$price',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              Text(
                '$sold đã bán',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Color(0x40000000),
            )
          ]),
          child: Row(
            children: const [
              Text(
                'Vận chuyển tới: ',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  'Phường Hòa Khánh Nam, quận Liên Chiểu, Đà Nẵng',
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Container(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
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
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Color(0x40000000))
                      ]),
                  child: const Center(
                    child: Text(
                      'Mua Ngay',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
