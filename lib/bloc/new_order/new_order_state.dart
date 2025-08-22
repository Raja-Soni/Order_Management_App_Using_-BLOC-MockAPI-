import 'package:equatable/equatable.dart';

class NewOrderState extends Equatable {
  final String name;
  final int quantity;
  final int price;
  final int totalPrice;

  const NewOrderState({
    this.name = "",
    this.quantity = 0,
    this.price = 0,
    this.totalPrice = 0,
  });

  NewOrderState copyWith({
    String? name,
    int? quantity,
    int? price,
    int? totalPrice,
  }) {
    return NewOrderState(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [name, quantity, price, totalPrice];
}
