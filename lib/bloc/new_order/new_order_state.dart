import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/item_model.dart';

class NewOrderState extends Equatable {
  final String customerName;
  late final String itemName;
  late final int quantity;
  late final int price;
  final bool isDelivered;
  final int totalPrice;
  final List<NewOrderDetailsItemModel> itemDetails;

  NewOrderState({
    this.customerName = "",
    this.itemName = "",
    this.quantity = 0,
    this.price = 0,
    this.totalPrice = 0,
    this.isDelivered = false,
    this.itemDetails = const [],
  });

  NewOrderState copyWith({
    String? customerName,
    String? itemName,
    int? quantity,
    int? price,
    bool? isDelivered,
    int? totalPrice,
    List<NewOrderDetailsItemModel>? itemDetails,
  }) {
    return NewOrderState(
      customerName: customerName ?? this.customerName,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isDelivered: isDelivered ?? this.isDelivered,
      totalPrice: totalPrice ?? this.totalPrice,
      itemDetails: itemDetails ?? this.itemDetails,
    );
  }

  @override
  List<Object?> get props => [
    customerName,
    itemName,
    quantity,
    price,
    isDelivered,
    totalPrice,
    itemDetails,
  ];
}
