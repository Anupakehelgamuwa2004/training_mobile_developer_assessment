import 'package:flutter/material.dart';
import 'package:training_mobile_developer_assessment/model/item_model.dart';
import 'package:training_mobile_developer_assessment/services/api_services.dart';

/// A provider class responsible for managing the state of items.
///
/// This class handles fetching items from an external data source via [ApiService],
/// maintains the loading status, error messages, and the list of fetched items, and notifies
/// its listeners on state changes.
class ItemProvider extends ChangeNotifier {
  /// Instance of [ApiService] used to retrieve items.
  final ApiService _apiService = ApiService();
  
  /// Indicates whether the items are currently being loaded.
  bool _isLoading = false;
  
  /// Contains any error message encountered during fetching.
  String _error = '';
  
  /// List of [ItemModel] objects fetched from the API.
  List<ItemModel> _items = [];

  /// Returns `true` if the provider is in the process of fetching items.
  bool get isLoading => _isLoading;
  
  /// Returns the error message if an error occurred during fetching.
  String get error => _error;
  
  /// Returns the list of fetched items.
  List<ItemModel> get items => _items;

  /// Asynchronously fetches items from the API.
  ///
  /// This method updates the [_isLoading] status, resets any previous error messages, and
  /// attempts to retrieve a list of items using [_apiService.fetchItems()]. On success,
  /// it updates the [_items] list; on failure, it sets an appropriate error message.
  /// Finally, it calls [notifyListeners] to update any listening widgets.
  Future<void> loadItems() async {
    // Start the loading process.
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      // Fetch items from the API service.
      _items = await _apiService.fetchItems();
    } catch (e) {
      // On failure, update the error message.
      _error = 'Failed to load items';
    }

    // End the loading process.
    _isLoading = false;
    notifyListeners();
  }
}
