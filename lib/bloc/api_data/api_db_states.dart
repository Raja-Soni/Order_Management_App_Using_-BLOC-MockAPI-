import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/sales_order.dart';

import '../../utils/enums.dart';

class APIDataBaseStates extends Equatable {
  final Status? apiStatus;
  final List<ItemModel> dataList;
  final String message;
  final Filters filter;

  const APIDataBaseStates({
    this.apiStatus = Status.loading,
    this.dataList = const [],
    this.message = "",
    this.filter = Filters.all,
  });

  APIDataBaseStates copyWith({
    Status? apiStatus,
    List<ItemModel>? dataList,
    String? message,
    Filters? filter,
  }) {
    return APIDataBaseStates(
      apiStatus: apiStatus ?? this.apiStatus,
      dataList: dataList ?? this.dataList,
      message: message ?? this.message,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [apiStatus, dataList, message, filter];
}
