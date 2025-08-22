import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_using_api/bloc/api_data/api_db_bloc.dart';
import 'package:erp_using_api/bloc/new_order/new_order_state.dart';

import '../../model/sales_order.dart';
import '../api_data/api_db_events.dart';
import 'new_order_events.dart';

class NewOrderBloc extends Bloc<NewOrderEvents, NewOrderState> {
  APIDataBaseBloc apiBloc;
  NewOrderBloc(this.apiBloc) : super(NewOrderState()) {
    on<InitialState>(initialState);
    on<NameGivenEvent>(nameGivenEvent);
    on<QuantityChangedEvent>(quantityChangedEvent);
    on<PriceChangedEvent>(priceChangedEvent);
    on<TotalPriceChangedEvent>(totalPriceChangedEvent);
    on<AddNewOrderEvent>(addNewOrderEvent);
  }

  FutureOr<void> initialState(InitialState event, Emitter<NewOrderState> emit) {
    emit(state.copyWith(totalPrice: 0, price: 0, quantity: 0, name: ""));
  }

  FutureOr<void> nameGivenEvent(
    NameGivenEvent event,
    Emitter<NewOrderState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> quantityChangedEvent(
    QuantityChangedEvent event,
    Emitter<NewOrderState> emit,
  ) {
    emit(state.copyWith(quantity: event.quantity));
  }

  FutureOr<void> priceChangedEvent(
    PriceChangedEvent event,
    Emitter<NewOrderState> emit,
  ) {
    emit(state.copyWith(price: event.price));
  }

  FutureOr<void> totalPriceChangedEvent(
    TotalPriceChangedEvent event,
    Emitter<NewOrderState> emit,
  ) {
    int price = state.price;
    int quantity = state.quantity;
    int totalPrice = price * quantity;
    if (totalPrice.isNaN) {
      emit(state.copyWith(totalPrice: 0));
    } else {
      emit(state.copyWith(totalPrice: totalPrice));
    }
  }

  addNewOrderEvent(AddNewOrderEvent event, Emitter<NewOrderState> emit) async {
    ItemModel newOrder = event.itemModel;
    apiBloc.add(AddItem(item: newOrder));
  }
}
