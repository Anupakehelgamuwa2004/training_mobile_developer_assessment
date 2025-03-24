import 'package:flutter/material.dart';
import 'package:training_mobile_developer_assessment/model/item_model.dart';


class ItemDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemModel item = ModalRoute.of(context)!.settings.arguments as ItemModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with error handling
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image, size: 100, color: Colors.grey.shade600),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              // Product Title
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              // Product Price
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 16),
              // Product Description
              Text(
                item.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
