import 'dart:convert';

const List<String> status = [
  'Chờ xử lý',
  'Đang chuẩn bị',
  'Đang giao',
  'Hủy đơn hàng'
];

class OrderHistoryModel {
  String productId;
  num quantity;
  String buyerId;
  String status;
  OrderHistoryModel({
    required this.productId,
    required this.quantity,
    required this.buyerId,
    required this.status,
  });

  OrderHistoryModel copyWith({
    String? productId,
    num? quantity,
    String? buyerId,
    String? status,
  }) {
    return OrderHistoryModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      buyerId: buyerId ?? this.buyerId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'quantity': quantity,
      'buyerId': buyerId,
      'status': status,
    };
  }

  factory OrderHistoryModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryModel(
      productId: map['productId'] as String,
      quantity: map['quantity'] as num,
      buyerId: map['buyerId'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryModel.fromJson(String source) =>
      OrderHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistoryModel(productId: $productId, quantity: $quantity, buyerId: $buyerId, status: $status)';
  }

  @override
  bool operator ==(covariant OrderHistoryModel other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.quantity == quantity &&
        other.buyerId == buyerId &&
        other.status == status;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        quantity.hashCode ^
        buyerId.hashCode ^
        status.hashCode;
  }
}
