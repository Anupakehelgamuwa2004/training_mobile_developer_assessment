import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/model/item_model.dart';
import 'package:training_mobile_developer_assessment/providers/auth_provider.dart';
import 'package:training_mobile_developer_assessment/providers/item_provider.dart';

/// The HomeScreen widget displays a dashboard with a list of items and
/// a navigation drawer (hamburger menu) that provides options like logout.
///
/// This widget uses [ItemProvider] to fetch and display items in a grid layout,
/// and [AuthProvider] to handle user authentication actions.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// The state class for [HomeScreen].
///
/// It initializes the item loading process and builds the UI including an AppBar,
/// Drawer for navigation, and a grid view for displaying items.
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger loading of items from the API or mock data as soon as the widget is initialized.
    Provider.of<ItemProvider>(context, listen: false).loadItems();
  }

  @override
  Widget build(BuildContext context) {
    // Obtain providers for authentication and item management.
    final authProvider = Provider.of<AuthProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueGrey,
      ),

      // Drawer provides a hamburger menu for additional navigation options.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader provides an optional area for branding or user information.
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'My Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // ListTile for the Logout option.
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                // Close the drawer before performing logout.
                Navigator.pop(context);
                // Execute logout via the AuthProvider.
                await authProvider.logout();
                // Navigate to the login screen after logout.
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // Main body content that displays the dashboard UI.
      body: Container(
        decoration: BoxDecoration(
          // Gradient background for a modern UI look.
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header text.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Your Dashboard!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            // Expanded widget ensures the grid view takes up remaining available space.
            Expanded(
              // Check if items are loading, or if there is an error, or display the grid.
              child: itemProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : itemProvider.error.isNotEmpty
                      ? Center(
                          child: Text(
                            itemProvider.error,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.all(16),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            // Adjust the aspect ratio to provide sufficient vertical space.
                            childAspectRatio: 0.65,
                          ),
                          itemCount: itemProvider.items.length,
                          itemBuilder: (context, index) {
                            final ItemModel item = itemProvider.items[index];
                            return GestureDetector(
                              // On tapping an item, navigate to its detail screen.
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detail',
                                  arguments: item,
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Display product image with rounded corners at the top.
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        item.imageUrl,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          // Fallback UI if the image fails to load.
                                          return Container(
                                            height: 120,
                                            width: double.infinity,
                                            color: Colors.grey.shade300,
                                            child: Icon(
                                              Icons.image,
                                              size: 50,
                                              color: Colors.grey.shade600,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Display item title.
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    // Display item description.
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        item.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    // Display item price.
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '\$${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
