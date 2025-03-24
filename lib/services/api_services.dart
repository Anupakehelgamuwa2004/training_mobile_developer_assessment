import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:training_mobile_developer_assessment/model/item_model.dart';


class ApiService {
  // Mocked fetch
  Future<List<ItemModel>> fetchItems() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Sample local data
    List<Map<String, dynamic>> mockData = [
      {
        'id': 1,
        'title': 'Item One',
        'description': 'Description of Item One',
      },
      {
        'id': 2,
        'title': 'Item Two',
        'description': 'Description of Item Two',
      },
    ];

    // Convert to ItemModel
    return mockData.map((json) => ItemModel.fromJson(json)).toList();
  }
}
