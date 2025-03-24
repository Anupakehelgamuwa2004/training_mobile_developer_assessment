import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:training_mobile_developer_assessment/model/item_model.dart';

/// A service class responsible for fetching item data from an external API.
///
/// This class provides methods to retrieve product data in JSON format,
/// parse the JSON into [ItemModel] instances, and return a list of items.
class ApiService {
  /// Fetches a list of [ItemModel] objects from the Fake Store API.
  ///
  /// This method sends an HTTP GET request to the [Fake Store API](https://fakestoreapi.com/products)
  /// to retrieve product data. If the request is successful (HTTP status 200), it decodes the
  /// JSON response and converts each JSON object into an [ItemModel] instance.
  ///
  /// Returns a [Future] that resolves to a list of [ItemModel] objects.
  ///
  /// Throws an [Exception] if the API call fails or returns a non-200 status code.
  Future<List<ItemModel>> fetchItems() async {
    // Construct the URL for the Fake Store API endpoint.
    final url = Uri.parse('https://fakestoreapi.com/products');

    // Send an HTTP GET request to the endpoint.
    final response = await http.get(url);

    // Check if the request was successful.
    if (response.statusCode == 200) {
      // Decode the JSON response into a list of dynamic objects.
      final List<dynamic> jsonData = json.decode(response.body);

      // Map each JSON object to an instance of ItemModel and return the resulting list.
      return jsonData.map((jsonItem) => ItemModel.fromJson(jsonItem)).toList();
    } else {
      // Throw an exception if the request failed.
      throw Exception('Failed to load items');
    }
  }
}
