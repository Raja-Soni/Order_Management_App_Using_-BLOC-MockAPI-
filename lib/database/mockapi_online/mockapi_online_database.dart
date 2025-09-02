import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/all_models.dart';

class OnlineDataBase {
  Future<List<SalesOrderListItemModel>> fetchData({int? page, limit}) async {
    List<SalesOrderListItemModel> result = [];
    final response;
    try {
      if (page != null && limit != null) {
        response = await http.get(
          Uri.parse(
            "https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp?page=$page&limit=$limit&sortBy=datetime&order=desc",
          ),
        );
      } else {
        response = await http.get(
          Uri.parse(
            "https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp?sortBy=datetime&order=desc",
          ),
        );
      }
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        result = body
            .map(
              (e) => SalesOrderListItemModel(
                id: e['id'] as String,
                customer: e['customer'] as String,
                amount: e['amount'] as int,
                status: e['status'] as String,
                dateAndTime: e['datetime'] as String,
                newOrderDetails:
                    (e['orderdetail'] as List<dynamic>?)
                        ?.map((item) => NewOrderDetailsItemModel.fromJson(item))
                        .toList() ??
                    [],
              ),
            )
            .toList();
      }
    } on Exception {
      throw Exception("Error Fetching Data");
    }
    return result;
  }

  deleteItem(String id) async {
    final response = await http.delete(
      Uri.parse("https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp/$id"),
    );
    if (response.statusCode != 200) {
      throw Exception(
        "Failed to delete Order: Response Status: ${response.statusCode}",
      );
    }
  }

  addItem(SalesOrderListItemModel item) async {
    final response = await http.post(
      Uri.parse("https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "customer": item.customer,
        "amount": item.amount,
        "status": item.status,
        "datetime": item.dateAndTime,
        "orderdetail": item.newOrderDetails?.map((e) => e.toJson()).toList(),
      }),
    );
    if (response.statusCode != 201) {
      throw Exception(
        "Failed to add Order: Response Status: ${response.statusCode}",
      );
    }
  }

  Future<void> updateStatus(String id, String newStatus) async {
    final response = await http.put(
      Uri.parse("https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"status": newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to update status. Response Status: ${response.statusCode}",
      );
    }
  }
}
