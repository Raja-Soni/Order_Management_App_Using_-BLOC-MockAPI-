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
}

class QuantityChangedEvent extends NewOrderEvents {
  final int quantity;
  QuantityChangedEvent({required this.quantity});
}

class PriceChangedEvent extends NewOrderEvents {
  final int price;
  PriceChangedEvent({required this.price});
}

class TotalPriceChangedEvent extends NewOrderEvents {}

class AddNewOrderEvent extends NewOrderEvents {
  final ItemModel itemModel;
  AddNewOrderEvent({required this.itemModel});
}
