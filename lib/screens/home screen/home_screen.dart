import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/providers/auth_provider.dart';
import 'package:training_mobile_developer_assessment/providers/item_provider.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          // Logout Button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              // Return to login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Text(
            'Welcome to Your Dashboard!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: itemProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : itemProvider.error.isNotEmpty
                    ? Center(child: Text(itemProvider.error))
                    : ListView.builder(
                        itemCount: itemProvider.items.length,
                        itemBuilder: (context, index) {
                          final item = itemProvider.items[index];
                          return ListTile(
                            title: Text(item.title),
                            subtitle: Text(item.description),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: item,
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
