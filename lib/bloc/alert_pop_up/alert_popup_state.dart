import 'package:equatable/equatable.dart';

import '../../utils/enums.dart';

class AlertPopUpStates extends Equatable {
  final bool pendingPopUpShow;
  final bool limitPopUpShow;
  final int pendingOrders;
  final int limitCrossedOrders;
  final int totalPendingOrderAmount;
  final Status apiStatus;

  const AlertPopUpStates({
    this.pendingPopUpShow = false,
    this.limitPopUpShow = true,
    this.pendingOrders = 0,
    this.limitCrossedOrders = 0,
    this.totalPendingOrderAmount = 0,
    this.apiStatus = Status.loading,
  });

  AlertPopUpStates copyWith({
    bool? pendingPopUpShow,
    bool? limitPopUpShow,
    int? pendingOrders,
    int? limitCrossedOrders,
    int? totalPendingOrderAmount,
    Status? apiStatus,
  }) {
    return AlertPopUpStates(
      pendingPopUpShow: pendingPopUpShow ?? this.pendingPopUpShow,
      limitPopUpShow: limitPopUpShow ?? this.limitPopUpShow,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      limitCrossedOrders: limitCrossedOrders ?? this.limitCrossedOrders,
      totalPendingOrderAmount:
          totalPendingOrderAmount ?? this.totalPendingOrderAmount,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => [
    pendingPopUpShow,
    limitPopUpShow,
    pendingOrders,
    totalPendingOrderAmount,
    limitCrossedOrders,
    apiStatus,
  ];
}
