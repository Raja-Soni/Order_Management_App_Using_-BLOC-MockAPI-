import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/sales_order_list_item_model.dart';

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
  final Filters filter;
  DeleteItem({required this.id, required this.filter});

  @override
  List<Object?> get props => [id];
}

class AddItem extends APIDataBaseEvents {
  final SalesOrderListItemModel? item;
  AddItem({required this.item});
  @override
  List<Object?> get props => [item];
}

class DetailedOrderPage extends APIDataBaseEvents {
  final int selectedOrderIndex;
  DetailedOrderPage({required this.selectedOrderIndex});

  @override
  List<Object?> get props => [selectedOrderIndex];
}

class UpdateSelectedOrderStatus extends APIDataBaseEvents {
  final String id;
  final String updateStatus;
  UpdateSelectedOrderStatus({required this.id, required this.updateStatus});
}
