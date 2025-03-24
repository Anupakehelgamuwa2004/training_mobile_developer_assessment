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
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Column(
        children: [
          Text(
            'Welcome! Here are your items:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (itemProvider.isLoading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (itemProvider.error.isNotEmpty)
            Expanded(child: Center(child: Text(itemProvider.error)))
          else
            Expanded(
              child: ListView.builder(
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
            )
        ],
      ),
    );
  }
}
