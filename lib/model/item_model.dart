/// A model class that represents an item or product in the system.
///
/// This model encapsulates the basic properties of an item, including
/// its unique identifier, title, description, price, and image URL. It
/// provides a factory constructor to create an instance from a JSON map.
class ItemModel {
  /// Unique identifier for the item.
  final int id;
  
  /// Title or name of the item.
  final String title;
  
  /// Detailed description of the item.
  final String description;
  
  /// Price of the item.
  final double price;
  
  /// URL of the item's image.
  final String imageUrl;

  /// Creates a new [ItemModel] instance with the given properties.
  ///
  /// All fields are required and must be provided when constructing an instance.
  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  /// Creates an [ItemModel] instance from a JSON object.
  ///
  /// This factory constructor parses the JSON map [json] and extracts the
  /// necessary fields. It converts the price to a double and maps the JSON key
  /// 'image' to [imageUrl].
  ///
  /// Throws a [FormatException] if the JSON is missing required fields.
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'], // Maps the 'image' JSON key to imageUrl.
    );
  }
}
