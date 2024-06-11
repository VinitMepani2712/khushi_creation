// lib/notifications_data.dart
import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
  });
}

List<NotificationItem> notifications = [
  NotificationItem(
    title: 'Order Shipped',
    message:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    time: '1h',
    icon: Icons.local_shipping,
  ),
  NotificationItem(
    title: 'Flash Sale Alert',
    message:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    time: '1h',
    icon: Icons.flash_on,
  ),
  NotificationItem(
    title: 'Product Review Request',
    message:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    time: '1h',
    icon: Icons.star_border,
  ),
  NotificationItem(
    title: 'Order Shipped',
    message:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    time: '1d',
    icon: Icons.local_shipping,
  ),
  NotificationItem(
    title: 'New Paypal Added',
    message:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    time: '1d',
    icon: Icons.account_balance_wallet,
  ),
  NotificationItem(
    title: 'Flash Sale Alert',
    message:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    time: '1d',
    icon: Icons.flash_on,
  ),
];
