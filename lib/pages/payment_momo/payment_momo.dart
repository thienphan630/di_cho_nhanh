import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/models/order_history_model.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:momo_vn/momo_vn.dart';

class MomoPayment extends StatefulWidget {
  const MomoPayment({super.key, required this.price});
  final num price;
  @override
  MomoPaymentState createState() => MomoPaymentState();
}

class MomoPaymentState extends State<MomoPayment> {
  late MomoVn _momoPay;
  PaymentResponse _momoPaymentResult =
      PaymentResponse(false, 7, '', '', '', '', '');
  String _paymentStatus = '';
  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('THANH TOÁN'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _onPaymentOffline();
                      },
                      child: const Text('THANH TOÁN TIỀN MẶT')),
                  ElevatedButton(
                    child: const Text('THANH TOÁN VỚI MOMO'),
                    onPressed: () async {
                      MomoPaymentInfo options = MomoPaymentInfo(
                          merchantName: "BigHero6PST",
                          appScheme: "1221212",
                          merchantCode: 'MOMOBCBD20221001',
                          partnerCode: 'MOMOBCBD20221001',
                          amount: widget.price.toInt(),
                          orderId: '12321312',
                          orderLabel: 'Cá thu ',
                          merchantNameLabel: "BigHero6PST",
                          fee: 10,
                          description: 'Thanh toán đơn hàng',
                          username: '0384168003',
                          partner: 'merchant',
                          extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                          isTestMode: true);
                      try {
                        _momoPay.open(options);
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                  ),
                ],
              ),
              Text(_paymentStatus.isEmpty
                  ? "BẠN CẦN THANH TOÁN ${widget.price.toInt()} VND"
                  : _paymentStatus.toUpperCase()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _onPaymentSuccess();
                  },
                  child: const Text('Quay lại'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";
      // _paymentStatus += "\nSố điện thoại: ${_momoPaymentResult.phoneNumber}";
      // _paymentStatus += "\nExtra: ${_momoPaymentResult.extra!}";
      // _paymentStatus += "\nToken: ${_momoPaymentResult.token}";
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      // _paymentStatus += "\nExtra: ${_momoPaymentResult.extra}";
      // _paymentStatus += "\nMã lỗi: ${_momoPaymentResult.status}";
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('THÀNH CÔNG: ${response.phoneNumber}')));
    CollectionReference<Map<String, dynamic>> orderHistory =
        FirebaseFirestore.instance.collection('order_history');
    CollectionReference<Map<String, dynamic>> cart = FirebaseFirestore.instance
        .collection('users')
        .doc(getUserId())
        .collection('cart');
    String userId = getUserId();
    //save history
    cart.get().then((value) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in value.docs) {
        String id = element.get('id');
        num quantity = element.get('quantity');
        var sellerId;
        FirebaseFirestore.instance
            .collection('products')
            .doc(id)
            .get()
            .then((value) => {sellerId = value.get('seller')})
            .then((_) {
          //save to local history
          DateTime today = DateTime.now();
          String dateSlug =
              "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
          orderHistory.add(OrderHistoryModel(
                  productId: id,
                  sellerId: sellerId,
                  quantity: quantity,
                  buyerId: userId,
                  status: status[0],
                  time: dateSlug)
              .toMap());
        });

        // tang san pham da ban them 1
        // product.doc(id).update({'sold': FieldValue.increment(1)});
      }
    });
    //delete cart
    cart.get().then((snapshot) {
      int length = snapshot.docs.length;
      for (int i = 0; i < length; i++) {
        QueryDocumentSnapshot<Map<String, dynamic>> data = snapshot.docs[i];
        cart
            .doc(data.id)
            .delete()
            .then((value) => log('Deleted'), onError: (e) => log('error: $e'));
      }
    });

    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('THẤT BẠI: ${response.message}')));
  }

  void _onPaymentSuccess() {
    if (_momoPaymentResult.isSuccess == true) {
      CollectionReference<Map<String, dynamic>> cart = FirebaseFirestore
          .instance
          .collection('users')
          .doc(getUserId())
          .collection('cart');

      cart.get().then((snapshot) {
        int length = snapshot.docs.length;
        for (int i = 0; i < length; i++) {
          QueryDocumentSnapshot<Map<String, dynamic>> data = snapshot.docs[i];
          cart.doc(data.id).delete().then((value) => log('Deleted'),
              onError: (e) => log('error: $e'));
        }
      });
    }
  }

  void _onPaymentOffline() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn đã chọn thanh toán bằng tiền mặt')));
    // CollectionReference<Map<String, dynamic>> product =
    //     FirebaseFirestore.instance.collection('products');
    CollectionReference<Map<String, dynamic>> orderHistory =
        FirebaseFirestore.instance.collection('order_history');
    CollectionReference<Map<String, dynamic>> cart = FirebaseFirestore.instance
        .collection('users')
        .doc(getUserId())
        .collection('cart');
    String userId = getUserId();
    //save history
    cart.get().then((value) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in value.docs) {
        String id = element.get('id');
        num quantity = element.get('quantity');
        var sellerId;
        FirebaseFirestore.instance
            .collection('products')
            .doc(id)
            .get()
            .then((value) => {sellerId = value.get('seller')})
            .then((_) {
          //save to local history
          DateTime today = DateTime.now();
          String dateSlug =
              "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
          orderHistory.add(OrderHistoryModel(
                  productId: id,
                  sellerId: sellerId,
                  quantity: quantity,
                  buyerId: userId,
                  status: status[0],
                  time: dateSlug)
              .toMap());
        });
      }
    });
    // delete cart
    cart.get().then((snapshot) {
      int length = snapshot.docs.length;
      for (int i = 0; i < length; i++) {
        QueryDocumentSnapshot<Map<String, dynamic>> data = snapshot.docs[i];
        cart
            .doc(data.id)
            .delete()
            .then((value) => log('Deleted'), onError: (e) => log('error: $e'));
      }
    });

    Navigator.pop(context);
  }
}
