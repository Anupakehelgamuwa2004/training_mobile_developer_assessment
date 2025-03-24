import 'package:flutter/material.dart';
import 'package:training_mobile_developer_assessment/model/item_model.dart';


class ItemDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemModel item = ModalRoute.of(context)!.settings.arguments as ItemModel;

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(item.description),
      ),
    );
  }
}
