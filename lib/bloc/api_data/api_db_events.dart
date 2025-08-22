import 'package:erp_using_api/model/sales_order.dart';

import '../../utils/enums.dart';

abstract class APIDataBaseEvents {}

class FetchOnlineData extends APIDataBaseEvents {}

class ApplyFilter extends APIDataBaseEvents {
  final Filters filter;
  ApplyFilter({required this.filter});
}

class DeleteItem extends APIDataBaseEvents {
  String? id;
  DeleteItem({required this.id});
}

class AddItem extends APIDataBaseEvents {
  ItemModel? item;
  AddItem({required this.item});
}
