import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  final String? id;
  final String? customer;
  final int? amount;
  final String? status;
  final String? dateAndTime;

  const ItemModel({
    this.id,
    required this.customer,
    required this.amount,
    required this.status,
    required this.dateAndTime,
  });

  @override
  List<Object?> get props => [id, customer, amount, status, dateAndTime];
}
