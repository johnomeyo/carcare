import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<NotificationItem> notifications = [
      NotificationItem(
        title: "Service Reminder",
        description: "Your car service is due in 3 days.",
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
      ),
      NotificationItem(
        title: "Special Offer",
        description: "Get 20% off on your next car wash.",
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationItem(
        title: "AI Assistant Tip",
        description: "Check your tire pressure monthly for better mileage.",
        dateTime: DateTime.now().subtract(const Duration(days: 5)),
        isRead: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: theme.textTheme.headlineSmall),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(notification: notification);
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = !notification.isRead;

    return Card(
      elevation: isUnread ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: Icon(
          isUnread ? Icons.notifications_active : Icons.notifications,
          color: isUnread
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
        ),
        title: Text(
          notification.title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          notification.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        trailing: Text(
          _formatDateTime(notification.dateTime),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

class NotificationItem {
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isRead = false,
  });
}
