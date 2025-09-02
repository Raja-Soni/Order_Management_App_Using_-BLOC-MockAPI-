import 'package:equatable/equatable.dart';

class NewOrderDetailsItemModel extends Equatable {
  final String? itemName;
  final int? quantity;
  final int? price;
  final int? totalItemsPrice;

  NewOrderDetailsItemModel({
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.totalItemsPrice,
  });

  factory NewOrderDetailsItemModel.fromJson(Map<String, dynamic> json) {
    return NewOrderDetailsItemModel(
      itemName: json['itemName'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      totalItemsPrice: json['totalItemsPrice'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
      'price': price,
      'totalItemsPrice': totalItemsPrice,
    };
  }

  @override
  List<Object?> get props => [itemName, quantity, price, totalItemsPrice];
}
