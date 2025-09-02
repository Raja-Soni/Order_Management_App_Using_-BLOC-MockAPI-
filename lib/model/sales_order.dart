import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/item_model.dart';

class ItemModel extends Equatable {
  final String? id;
  final String? customer;
  final int? amount;
  final String? status;
  final String? dateAndTime;
  final List<NewOrderDetailsItemModel>? newOrderDetails;

  const ItemModel({
    this.id,
    required this.customer,
    required this.amount,
    required this.status,
    required this.dateAndTime,
    required this.newOrderDetails,
  });

  @override
  List<Object?> get props => [
    id,
    customer,
    amount,
    status,
    dateAndTime,
    newOrderDetails,
  ];
}
