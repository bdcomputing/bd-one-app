import 'package:flutter/material.dart';

enum TransactionType { invoice, payment }

class BaseTransaction {
  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final DateTime date;
  final String status;
  final Color statusColor;
  final TransactionType type;
  final dynamic icon;
  final dynamic originalData; // Holds the original Invoice or Payment object

  BaseTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.type,
    required this.icon,
    this.originalData,
  });
}
