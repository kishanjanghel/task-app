import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/datamodel/notificatoin_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifications",
      ),
      body: ListView.separated(
        itemCount: dummyNotifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final notification = dummyNotifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(notification.title),
            subtitle: Text(notification.body),
            trailing: Text(
              DateFormat('MMM d, h:mm a').format(notification.dateTime),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
