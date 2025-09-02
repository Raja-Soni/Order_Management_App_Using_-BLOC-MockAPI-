import 'package:equatable/equatable.dart';

abstract class NewOrderEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends NewOrderEvents {}

class CustomerNameGivenEvent extends NewOrderEvents {
  final String name;
  CustomerNameGivenEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class QuantityChangedEvent extends NewOrderEvents {
  final int quantity;
  QuantityChangedEvent({required this.quantity});
  @override
  List<Object?> get props => [quantity];
}

class PriceChangedEvent extends NewOrderEvents {
  final int price;
  PriceChangedEvent({required this.price});

  @override
  List<Object?> get props => [price];
}

class TotalPriceChangedEvent extends NewOrderEvents {}

class OrderDeliveryStatusChangedEvent extends NewOrderEvents {
  final bool isDelivered;
  OrderDeliveryStatusChangedEvent({required this.isDelivered});
}

class OrderItemDetailedList extends NewOrderEvents {}

class AddNewOrderEvent extends NewOrderEvents {}

class NewItemDetails extends NewOrderEvents {
  final String? itemName;
  final int? price;
  final int? quantity;
  NewItemDetails({this.price, this.quantity, this.itemName});

  @override
  List<Object?> get props => [itemName, price, quantity];
}

class RemoveItemFromList extends NewOrderEvents {
  final int itemIndex;
  RemoveItemFromList({required this.itemIndex});

  @override
  List<Object?> get props => [itemIndex];
}
