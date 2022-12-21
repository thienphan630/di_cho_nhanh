// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

const List<String> status = [
  'Chờ xử lý',
  'Đang chuẩn bị',
  'Đang giao',
  'Hủy đơn hàng'
];

class OrderHistoryModel {
  String productId;
  String sellerId;
  num quantity;
  String buyerId;
  String status;
  String time;
  OrderHistoryModel({
    required this.productId,
    required this.sellerId,
    required this.quantity,
    required this.buyerId,
    required this.status,
    required this.time,
  });
  

  OrderHistoryModel copyWith({
    String? productId,
    String? sellerId,
    num? quantity,
    String? buyerId,
    String? status,
    String? time,
  }) {
    return OrderHistoryModel(
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      quantity: quantity ?? this.quantity,
      buyerId: buyerId ?? this.buyerId,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'sellerId': sellerId,
      'quantity': quantity,
      'buyerId': buyerId,
      'status': status,
      'time': time,
    };
  }

  factory OrderHistoryModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryModel(
      productId: map['productId'] as String,
      sellerId: map['sellerId'] as String,
      quantity: map['quantity'] as num,
      buyerId: map['buyerId'] as String,
      status: map['status'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryModel.fromJson(String source) => OrderHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistoryModel(productId: $productId, sellerId: $sellerId, quantity: $quantity, buyerId: $buyerId, status: $status, time: $time)';
  }

  @override
  bool operator ==(covariant OrderHistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.sellerId == sellerId &&
      other.quantity == quantity &&
      other.buyerId == buyerId &&
      other.status == status &&
      other.time == time;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      sellerId.hashCode ^
      quantity.hashCode ^
      buyerId.hashCode ^
      status.hashCode ^
      time.hashCode;
  }
}
