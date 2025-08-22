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
    on<ApplyFilter>(applyFilter);
    on<DeleteItem>(deleteItem);
    on<AddItem>(addItem);
  }

  void fetchOnlineData(
    FetchOnlineData event,
    Emitter<APIDataBaseStates> emit,
  ) async {
    await dataBase
        .fetchData()
        .then((value) {
          tempList = value;
          emit(
            state.copyWith(
              dataList: tempList,
              message: "Data fetch Success",
              apiStatus: Status.success,
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

  applyFilter(ApplyFilter event, Emitter<APIDataBaseStates> emit) async {
    emit(state.copyWith(apiStatus: Status.loading, message: "loading"));
    await dataBase.fetchData().then((value) {
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
        ),
      );
    });
  }

  deleteItem(DeleteItem event, Emitter<APIDataBaseStates> emit) async {
    emit(state.copyWith(apiStatus: Status.loading));
    String? id = event.id;
    tempList.removeWhere((item) => item.id == event.id);
    await dataBase.deleteItem(id!);
    await dataBase.fetchData().then((value) {
      tempList = value;
      emit(
        state.copyWith(
          dataList: List.from(tempList),
          apiStatus: Status.success,
          message: "Item Deleted",
        ),
      );
    });
  }

  addItem(AddItem event, Emitter<APIDataBaseStates> emit) async {
    emit(state.copyWith(apiStatus: Status.loading));
    tempList.add(event.item!);
    await dataBase.addItem(event.item!);
    await dataBase.fetchData().then((value) {
      tempList = value;
      emit(
        state.copyWith(
          dataList: List.from(tempList),
          apiStatus: Status.success,
          message: "Item added",
        ),
      );
    });
  }
}
