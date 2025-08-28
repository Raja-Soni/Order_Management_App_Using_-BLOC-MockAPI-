import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/sales_order.dart';

import '../../utils/enums.dart';

abstract class APIDataBaseEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchOnlineData extends APIDataBaseEvents {}

class FetchMoreData extends APIDataBaseEvents {
  final int page;
  FetchMoreData({required this.page});

  @override
  List<Object?> get props => [page];
}

class ApplyFilter extends APIDataBaseEvents {
  final Filters filter;
  ApplyFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class DeleteItem extends APIDataBaseEvents {
  final String? id;
  DeleteItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class AddItem extends APIDataBaseEvents {
  final ItemModel? item;
  AddItem({required this.item});

  @override
  List<Object?> get props => [item];
}
