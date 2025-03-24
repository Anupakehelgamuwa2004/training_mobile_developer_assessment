import 'dart:convert';

import 'package:training_mobile_developer_assessment/model/item_model.dart';


class ApiService {
  Future<List<ItemModel>> fetchItems() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Sample product line data
    final List<Map<String, dynamic>> mockData = [
      {
        'id': 1,
        'title': 'Smartphone',
        'description': 'Latest model with advanced features.',
        'price': 699.99,
        'imageUrl': 'https://via.placeholder.com/150'
      },
      {
        'id': 2,
        'title': 'Laptop',
        'description': 'High-performance laptop for work and play.',
        'price': 1299.99,
        'imageUrl': 'https://via.placeholder.com/150'
      },
      {
        'id': 3,
        'title': 'Smartwatch',
        'description': 'Stylish smartwatch with health tracking.',
        'price': 299.99,
        'imageUrl': 'https://via.placeholder.com/150'
      },
      {
        'id': 4,
        'title': 'Headphones',
        'description': 'Noise-cancelling over-ear headphones.',
        'price': 199.99,
        'imageUrl': 'https://via.placeholder.com/150'
      },
    ];

    return mockData.map((json) => ItemModel.fromJson(json)).toList();
  }
}
