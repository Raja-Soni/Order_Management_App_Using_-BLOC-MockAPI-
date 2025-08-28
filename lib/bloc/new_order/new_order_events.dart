import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/sales_order.dart';

abstract class NewOrderEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends NewOrderEvents {}

class NameGivenEvent extends NewOrderEvents {
  final String name;
  NameGivenEvent({required this.name});

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

class AddNewOrderEvent extends NewOrderEvents {
  final ItemModel itemModel;
  AddNewOrderEvent({required this.itemModel});

  @override
  List<Object?> get props => [itemModel];
}
