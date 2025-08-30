import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/sales_order.dart';

class OnlineDataBase {
  Future<List<ItemModel>> fetchData({int? page, limit}) async {
    List<ItemModel> result = [];
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
              (e) => ItemModel(
                id: e['id'] as String,
                customer: e['customer'] as String,
                amount: e['amount'] as int,
                status: e['status'] as String,
                dateAndTime: e['datetime'] as String,
              ),
            )
            .toList();
      }
    } on Exception {
      throw Exception("Error");
    }
    return result;
  }

  deleteItem(String id) async {
    final response = await http.delete(
      Uri.parse("https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp/$id"),
    );
    if (response.statusCode != 200) {
      throw Exception("Response Status: ${response.statusCode}");
    }
  }

  addItem(ItemModel item) async {
    final response = await http.post(
      Uri.parse("https://68a2c29fc5a31eb7bb1dad0c.mockapi.io/erp_miniapp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "customer": item.customer,
        "amount": item.amount,
        "status": item.status,
        "datetime": item.dateAndTime,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception("Response Status: ${response.statusCode}");
    }
  }
}
