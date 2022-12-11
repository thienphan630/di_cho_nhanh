import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/models/agruments/product_type.dart';
import 'package:di_cho_nhanh/models/product_modal.dart';
import 'package:di_cho_nhanh/pages/add_product_screen/widgets/pick_image.dart';
import 'package:di_cho_nhanh/pages/add_product_screen/widgets/select_product_type.dart';
import 'package:di_cho_nhanh/pages/homepage/widget/home_widgets.dart';
import 'package:di_cho_nhanh/widgets/title_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    String? imageBase64;
    ProductType type = ProductType.undefine;
    TextEditingController name = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController quantity = TextEditingController();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: titleAppBar('Đăng hàng mới'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thông Tin Hàng',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    height: 3,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Những thông tin bên dưới của bạn sẽ được công khai để người Mua hàng có thể liên lạc trao đổi về sản phẩm.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Vui lòng nhập tên sản phẩm';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                            formKey.currentState!.validate();
                          },
                          cursorHeight: 20,
                          controller: name,
                          style: const TextStyle(fontSize: 16.0),
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(fontSize: 10),
                              labelText: 'Tên sản phẩm',
                              labelStyle: TextStyle(fontSize: 16.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)))),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                            validator: (value) {
                              num? a = num.tryParse(value!);
                              num b = a ?? 0;
                              if (value.isEmpty) {
                                return 'Vui lòng nhập giá tiền';
                              }
                              if (b < 0) {
                                return 'Giá tiền không thể bé hơn 0';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                              formKey.currentState!.validate();
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            cursorHeight: 20,
                            controller: price,
                            decoration: const InputDecoration(
                                errorStyle: TextStyle(fontSize: 10),
                                labelText: 'Giá tiền',
                                labelStyle: TextStyle(fontSize: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))))),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SelectProductType(
                  callback: (value) {
                    type = value;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Mô tả sản phẩm bạn cần mua:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                TextFormField(
                  cursorHeight: 20,
                  controller: description,
                  decoration: const InputDecoration(
                      labelText: 'Mô tả sản phẩm',
                      labelStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0)))),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Số lượng:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: TextFormField(
                      validator: (value) {
                        num? a = num.tryParse(value!);
                        num b = a ?? 0;
                        if (value.isEmpty) {
                          return 'Vui lòng nhập số lượng';
                        }
                        if (b < 0) {
                          return 'Số lượng không thể bé hơn 0';
                        }
                        return null;
                      },
                      onEditingComplete: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        formKey.currentState!.validate();
                      },
                      keyboardType: TextInputType.number,
                      cursorHeight: 20,
                      controller: quantity,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(fontSize: 10),
                        labelText: 'Số lượng',
                        labelStyle: TextStyle(fontSize: 16.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Ảnh sản phẩm cần bán:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    PickImage(
                      callback: (value) {
                        imageBase64 = value;
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                Align(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // log(imageBase64 ?? defaultImage);
                          // log('${name.text} ${price.text} ${description.text} ${quantity.text}');
                          String sellerId = '';
                          if (FirebaseAuth.instance.currentUser != null) {
                            sellerId = FirebaseAuth.instance.currentUser!.uid;
                          }
                          var product =
                              FirebaseFirestore.instance.collection('products');
                          product.add(ProductModal(
                                  name: name.text,
                                  image: imageBase64 ?? defaultImage,
                                  price: num.parse(price.text),
                                  quantity: num.parse(quantity.text),
                                  sold: 0,
                                  stars: 5,
                                  type: productCategories(type),
                                  seller: sellerId)
                              .toMap());
                        } else {
                          log('error');
                        }
                      },
                      child: Text(
                        'Đăng hàng'.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
