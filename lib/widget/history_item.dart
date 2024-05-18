// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_door_lock/models/history.dart';

class HistoryItem extends StatelessWidget {
  final History history;
  const HistoryItem({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          history.imageUrl,
          height: 125,
          width: 125,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image,
              size: 50,
            );
          },
        ),
        title: Text(history.name),
        subtitle: Text(history.time.toUtc().toString()),
      ),
    );
  }
}
