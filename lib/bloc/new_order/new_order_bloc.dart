import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_using_api/bloc/api_data/api_bloc_events_state.dart';
import 'package:erp_using_api/bloc/new_order/new_order_bloc_events_state.dart';
import 'package:erp_using_api/model/all_models.dart';

class NewOrderBloc extends Bloc<NewOrderEvents, NewOrderState> {
  APIDataBaseBloc apiBloc;
  NewOrderBloc(this.apiBloc) : super(NewOrderState()) {
    on<InitialState>(initialState);
    on<CustomerNameGivenEvent>(customerNameGivenEvent);
    on<TotalPriceChangedEvent>(totalPriceChangedEvent);
    on<OrderDeliveryStatusChangedEvent>(orderDeliveryStatusChangedEvent);
    on<OrderItemDetailedList>(orderItemDetailedList);
    on<AddNewOrderEvent>(addNewOrderEvent);
    on<RemoveItemFromList>(removeItemFromList);
    on<NewItemDetails>(newItemDetails);
  }

  FutureOr<void> initialState(InitialState event, Emitter<NewOrderState> emit) {
    emit(state.copyWith(totalPrice: 0, isDelivered: false, itemDetails: []));
  }

  FutureOr<void> customerNameGivenEvent(
    CustomerNameGivenEvent event,
    Emitter<NewOrderState> emit,
  ) {
    emit(state.copyWith(customerName: event.name));
  }

  FutureOr<void> totalPriceChangedEvent(
    TotalPriceChangedEvent event,
    Emitter<NewOrderState> emit,
  ) {
    int totalPrice = state.itemDetails.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.totalItemsPrice ?? 0),
    );
    emit(state.copyWith(totalPrice: totalPrice));
  }

  addNewOrderEvent(AddNewOrderEvent event, Emitter<NewOrderState> emit) async {
    SalesOrderListItemModel newOrderItem = SalesOrderListItemModel(
      customer: state.customerName,
      amount: state.totalPrice,
      status: state.isDelivered ? "Delivered" : "Pending",
      dateAndTime: DateTime.now().toString(),
      newOrderDetails: state.itemDetails,
    );
    apiBloc.add(AddItem(item: newOrderItem));
  }

  FutureOr<void> orderDeliveryStatusChangedEvent(
    OrderDeliveryStatusChangedEvent event,
    Emitter<NewOrderState> emit,
  ) {
    emit(state.copyWith(isDelivered: event.isDelivered));
  }

  FutureOr<void> orderItemDetailedList(
    OrderItemDetailedList event,
    Emitter<NewOrderState> emit,
  ) {
    final List<NewOrderDetailsItemModel> updatedList =
        List.from(state.itemDetails)..add(
          NewOrderDetailsItemModel(
            itemName: state.itemName,
            quantity: state.quantity,
            price: state.price,
            totalItemsPrice: (state.quantity * state.price),
          ),
        );
    emit(
      state.copyWith(
        itemDetails: updatedList,
        price: 0,
        quantity: 0,
        itemName: "",
        totalPrice: 0,
      ),
    );
  }

  FutureOr<void> removeItemFromList(
    RemoveItemFromList event,
    Emitter<NewOrderState> emit,
  ) {
    final List<NewOrderDetailsItemModel> updatedList = List.from(
      state.itemDetails,
    );
    updatedList.removeAt(event.itemIndex);
    emit(state.copyWith(itemDetails: updatedList));
  }

  FutureOr<void> newItemDetails(
    NewItemDetails event,
    Emitter<NewOrderState> emit,
  ) {
    emit(
      state.copyWith(
        itemName: event.itemName,
        price: event.price,
        quantity: event.quantity,
      ),
    );
  }
}
