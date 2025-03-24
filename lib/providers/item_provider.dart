import 'package:flutter/material.dart';
import 'package:training_mobile_developer_assessment/model/item_model.dart';
import 'package:training_mobile_developer_assessment/services/api_services.dart';


class ItemProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String _error = '';
  List<ItemModel> _items = [];

  bool get isLoading => _isLoading;
  String get error => _error;
  List<ItemModel> get items => _items;

  Future<void> loadItems() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _items = await _apiService.fetchItems();
    } catch (e) {
      _error = 'Failed to load items';
    }

    _isLoading = false;
    notifyListeners();
  }
}
