import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/sales_order.dart';

import '../../utils/enums.dart';

class APIDataBaseStates extends Equatable {
  final Status? apiStatus;
  final List<ItemModel> dataList;
  final String message;
  final Filters filter;
  final int page;
  final bool hasMoreData;

  const APIDataBaseStates({
    this.apiStatus = Status.loading,
    this.dataList = const [],
    this.message = "",
    this.filter = Filters.all,
    this.page = 1,
    this.hasMoreData = true,
  });

  APIDataBaseStates copyWith({
    Status? apiStatus,
    List<ItemModel>? dataList,
    String? message,
    Filters? filter,
    int? page,
    bool? hasMoreData,
  }) {
    return APIDataBaseStates(
      apiStatus: apiStatus ?? this.apiStatus,
      dataList: dataList ?? this.dataList,
      message: message ?? this.message,
      filter: filter ?? this.filter,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }

  @override
  List<Object?> get props => [
    apiStatus,
    dataList,
    message,
    filter,
    page,
    hasMoreData,
  ];
}
