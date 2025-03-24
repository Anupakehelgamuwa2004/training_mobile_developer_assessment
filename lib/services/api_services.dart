import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:training_mobile_developer_assessment/model/item_model.dart';

class ApiService {

  Future<List<ItemModel>> fetchItems() async {
    // Mocked response:
    // In a real-world scenario, you'd call an actual endpoint.
    // e.g., final response = await http.get(Uri.parse('https://api.example.com/items'));
    await Future.delayed(Duration(seconds: 1)); // simulate network delay
    final mockData = [
      {
        "id": 1,
        "title": "Item One",
        "description": "Description of Item One"
      },
      {
        "id": 2,
        "title": "Item Two",
        "description": "Description of Item Two"
      },
      {
        "id": 3,
        "title": "Item Three",
        "description": "Description of Item Three"
      }
    ];

    // If you use a real API, parse the response accordingly:
    // final data = json.decode(response.body);
    return mockData.map((e) => ItemModel.fromJson(e)).toList();
  }
}
