import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_bloc_events_state.dart';
import 'package:erp_using_api/bloc/api_data/api_bloc_events_state.dart';
import 'package:erp_using_api/model/sales_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertPopUpBloc extends Bloc<AlertPopUpEvents, AlertPopUpStates> {
  APIDataBaseBloc api;
  AlertPopUpBloc(this.api) : super(AlertPopUpStates()) {
    on<GetPendingAndLimitCrossedOrders>(getPendingAndLimitCrossedOrders);
    on<PendingPopupShown>(pendingPopupShown);
    on<InitHighOrderAlert>(initHighOrderAlert);
    on<GetHighOrderAlert>(getHighOrderAlert);
    on<ClearHighOrderAlert>(clearHighOrderAlert);
    on<LimitCrossedPopupShown>(limitCrossedPopupShown);
  }

  Future<void> getPendingAndLimitCrossedOrders(
    GetPendingAndLimitCrossedOrders event,
    Emitter<AlertPopUpStates> emit,
  ) async {
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

  FutureOr<void> initHighOrderAlert(
    InitHighOrderAlert event,
    Emitter<AlertPopUpStates> emit,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("HighOrderDetected", event.name);
    sp.setInt("LastHighOrderAmount", event.amount);
  }

  FutureOr<void> getHighOrderAlert(
    GetHighOrderAlert event,
    Emitter<AlertPopUpStates> emit,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? name = sp.getString("HighOrderDetected");
    int? amount = sp.getInt("LastHighOrderAmount");
    if (name != null && amount != null) {
      emit(
        state.copyWith(
          lastHighOrderCustomerName: name,
          lastHighOrderCustomerAmount: amount,
        ),
      );
    }
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

  FutureOr<void> clearHighOrderAlert(
    ClearHighOrderAlert event,
    Emitter<AlertPopUpStates> emit,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("HighOrderDetected");
    sp.remove("LastHighOrderAmount");
    emit(state.copyWith(highOrderAlertPopupShow: true));
  }
}
