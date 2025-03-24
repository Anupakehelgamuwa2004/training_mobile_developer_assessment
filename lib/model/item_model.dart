class ItemModel {
  final int id;
  final String title;
  final String description;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
