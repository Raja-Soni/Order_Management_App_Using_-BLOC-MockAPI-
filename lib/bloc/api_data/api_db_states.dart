import 'package:equatable/equatable.dart';
import 'package:erp_using_api/model/all_models.dart';

import '../../utils/enums.dart';

class APIDataBaseStates extends Equatable {
  final Status? apiStatus;
  final List<SalesOrderListItemModel> dataList;
  final String message;
  final Filters filter;
  final int page;
  final int limit;
  final bool hasMoreData;
  final int selectedOrderIndex;

  const APIDataBaseStates({
    this.apiStatus = Status.loading,
    this.dataList = const [],
    this.message = "",
    this.filter = Filters.all,
    this.page = 1,
    this.hasMoreData = true,
    this.limit = 10,
    this.selectedOrderIndex = 0,
  });

  APIDataBaseStates copyWith({
    Status? apiStatus,
    List<SalesOrderListItemModel>? dataList,
    String? message,
    Filters? filter,
    int? page,
    bool? hasMoreData,
    int? limit,
    int? selectedOrderIndex,
  }) {
    return APIDataBaseStates(
      apiStatus: apiStatus ?? this.apiStatus,
      dataList: dataList ?? this.dataList,
      message: message ?? this.message,
      filter: filter ?? this.filter,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      selectedOrderIndex: selectedOrderIndex ?? this.selectedOrderIndex,
    );
  }

  @override
  List<Object?> get props => [
    apiStatus,
    dataList,
    message,
    filter,
    page,
    limit,
    hasMoreData,
    selectedOrderIndex,
  ];
}
