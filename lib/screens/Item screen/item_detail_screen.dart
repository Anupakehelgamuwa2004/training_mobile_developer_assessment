import 'package:flutter/material.dart';
import 'package:training_mobile_developer_assessment/model/item_model.dart';

/// A screen that displays detailed information for a selected item.
///
/// The [ItemDetailScreen] shows an item's image, title, price, and description.
/// It employs a [Hero] widget to provide a smooth transition for the image
/// when navigating from a list or grid view.
class ItemDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the item passed as an argument via the navigation route.
    final ItemModel item =
        ModalRoute.of(context)!.settings.arguments as ItemModel;

    return Scaffold(
      appBar: AppBar(
        // Display the item title in the AppBar.
        title: Text(item.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        // Apply a gradient background for a modern look.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          // Wrap content in padding for proper spacing.
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero widget for smooth image transition from the previous screen.
                Hero(
                  tag: 'itemImage-${item.id}',
                  child: ClipRRect(
                    // Apply rounded corners to the image.
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      // Provide a fallback UI in case the image fails to load.
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Row to display the item title and price side by side.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded widget to ensure the title uses available horizontal space.
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        // Limit the title to two lines with an ellipsis overflow.
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Display the item's price.
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Divider to visually separate header information from the description.
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
                SizedBox(height: 16),
                // Display the product description with improved line height for readability.
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
