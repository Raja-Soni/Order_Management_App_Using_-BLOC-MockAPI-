import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_using_api/bloc/api_data/api_db_events.dart';
import 'package:erp_using_api/bloc/api_data/api_db_states.dart';
import 'package:erp_using_api/database/mockapi_online/mockapi_online_database.dart';

import '../../model/sales_order.dart';
import '../../utils/enums.dart';

class APIDataBaseBloc extends Bloc<APIDataBaseEvents, APIDataBaseStates> {
  OnlineDataBase dataBase = OnlineDataBase();
  List<ItemModel> tempList = [];
  APIDataBaseBloc() : super(APIDataBaseStates()) {
    on<FetchOnlineData>(fetchOnlineData);
    on<FetchMoreData>(fetchMoreData);
    on<ApplyFilter>(applyFilter);
    on<DeleteItem>(deleteItem);
    on<AddItem>(addItem);
  }

  void fetchOnlineData(
    FetchOnlineData event,
    Emitter<APIDataBaseStates> emit,
  ) async {
    await dataBase
        .fetchData(page: 1)
        .then((value) {
          tempList = List.from(value);
          emit(
            state.copyWith(
              dataList: List.from(tempList),
              message: "Data fetch Success",
              page: 1,
              apiStatus: Status.success,
              hasMoreData: value.length == 10,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              apiStatus: Status.failure,
              message: error.toString(),
            ),
          );
        });
  }

  Future<void> fetchMoreData(
    FetchMoreData event,
    Emitter<APIDataBaseStates> emit,
  ) async {
    await dataBase
        .fetchData(page: event.page)
        .then((value) {
          if (value.isEmpty) {
            emit(state.copyWith(hasMoreData: false));
          } else {
            for (var item in value) {
              if (!tempList.any((existing) => existing.id == item.id)) {
                tempList.add(item);
              }
            }
            emit(
              state.copyWith(
                hasMoreData: value.isNotEmpty && value.length >= 10,
                dataList: List.from(tempList),
                message: "Data fetch Success",
                apiStatus: Status.success,
                page: event.page,
              ),
            );
          }
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              apiStatus: Status.failure,
              message: error.toString(),
            ),
          );
        });
  }

  applyFilter(ApplyFilter event, Emitter<APIDataBaseStates> emit) async {
    emit(state.copyWith(apiStatus: Status.loading, message: "loading"));
    await dataBase.fetchData(page: 1).then((value) {
      if (event.filter == Filters.all) {
        tempList = value;
      } else if (event.filter == Filters.today) {
        tempList = value
            .where(
              (item) => item.date == DateTime.now().toString().split(" ").first,
            )
            .toList();
      } else if (event.filter == Filters.delivered) {
        tempList = value.where((item) => item.status == "Delivered").toList();
      } else if (event.filter == Filters.pending) {
        tempList = value.where((item) => item.status == "Pending").toList();
      }
      emit(
        state.copyWith(
          dataList: List.from(tempList),
          message: "Filter applied",
          apiStatus: Status.success,
          filter: event.filter,
          hasMoreData: tempList.length >= 10,
          page: 1,
        ),
      );
    });
  }

  deleteItem(DeleteItem event, Emitter<APIDataBaseStates> emit) async {
    emit(state.copyWith(apiStatus: Status.loading));
    String? id = event.id;
    await dataBase.deleteItem(id!);
    await dataBase.fetchData(page: 1).then((value) {
      tempList = List.from(value);
      emit(
        state.copyWith(
          dataList: List.from(tempList),
          apiStatus: Status.success,
          page: 1,
          message: "Item Deleted",
          hasMoreData: tempList.length >= 10,
        ),
      );
    });
  }

  addItem(AddItem event, Emitter<APIDataBaseStates> emit) async {
    emit(state.copyWith(apiStatus: Status.loading));
    await dataBase.addItem(event.item!);
    await dataBase.fetchData(page: 1).then((value) {
      tempList = List.from(value);
      emit(
        state.copyWith(
          dataList: List.from(tempList),
          apiStatus: Status.success,
          message: "Item added",
          page: 1,
          hasMoreData: tempList.length >= 10,
        ),
      );
    });
  }
}
