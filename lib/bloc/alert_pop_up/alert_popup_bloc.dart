import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_events.dart';
import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_state.dart';
import 'package:erp_using_api/bloc/api_data/api_db_bloc.dart';
import 'package:erp_using_api/model/sales_order.dart';

class AlertPopUpBloc extends Bloc<AlertPopUpEvents, AlertPopUpStates> {
  APIDataBaseBloc api;
  AlertPopUpBloc(this.api) : super(AlertPopUpStates()) {
    on<GetPendingAndLimitCrossedOrders>(getPendingAndLimitCrossedOrders);
    on<PendingPopupShown>(pendingPopupShown);
    on<LimitCrossedPopupShown>(limitCrossedPopupShown);
  }

  FutureOr<void> getPendingAndLimitCrossedOrders(
    GetPendingAndLimitCrossedOrders event,
    Emitter<AlertPopUpStates> emit,
  ) {
    emit(state.copyWith(apiStatus: api.state.apiStatus));
    List<ItemModel> pendingList = [];
    pendingList = api.tempList
        .where((item) => item.status == "Pending")
        .toList();
    int pendingOrders = pendingList.length;
    int totalPendingAmount = 0;
    for (var pendList in pendingList) {
      totalPendingAmount += pendList.amount!;
    }

    List<ItemModel> limitCrossedOrdersList = [];
    limitCrossedOrdersList = api.tempList
        .where((item) => item.amount! > 10000)
        .toList();
    int limitCrossedOrders = limitCrossedOrdersList.length;
    emit(
      state.copyWith(
        totalPendingOrderAmount: totalPendingAmount,
        pendingOrders: pendingOrders,
        limitCrossedOrders: limitCrossedOrders,
        apiStatus: api.state.apiStatus,
      ),
    );
  }

  FutureOr<void> pendingPopupShown(
    PendingPopupShown event,
    Emitter<AlertPopUpStates> emit,
  ) {
    emit(state.copyWith(pendingPopUpShow: event.isShown));
  }

  FutureOr<void> limitCrossedPopupShown(
    LimitCrossedPopupShown event,
    Emitter<AlertPopUpStates> emit,
  ) {
    emit(state.copyWith(limitPopUpShow: event.show));
  }
}
