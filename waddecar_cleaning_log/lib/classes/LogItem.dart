import 'package:flutter/material.dart';
import '../widgets/components/itemCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogItem {
  final String? docID;
  final int priority;
  final String title;
  final String description;
  final String location;
  final String jobType;
  final DateTime? dueBy;
  final DateTime? availableFrom;
  final int completed; // 0, not completed; 1, in progress; 2, completed

  LogItem({
    required this.priority,
    required this.title,
    required this.description,
    required this.location,
    required this.jobType,
    required this.completed,
    this.docID,
    this.dueBy,
    this.availableFrom,
  });

  factory LogItem.fromJson(String ID, Map<String, dynamic> json) {

    // DateTime? dueByDate = null;
    // if (json['dueBy'] != null) {
    //   try {
    //     dueByDate = (json['dueBy'] as Timestamp).toDate();
    //   } catch (e) {
    //     print(e.toString());
    //     dueByDate = null;
    //   }
    // }

    // DateTime? availableFromDate = null;
    // if (json['availableFrom'] != null) {
    //   try {
    //     availableFromDate = (json['availableFrom'] as Timestamp).toDate();
    //   } catch (e) {
    //     print(e.toString());
    //     availableFromDate = null;
    //   }
    // }

    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return LogItem(
      priority: json['priority'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      jobType: json['jobType'] ?? '',
      completed: json['completion'] ?? 0,
      dueBy: parseDate(json['dueBy']),
      docID: ID,
      availableFrom: parseDate(json['availableFrom'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priority': priority,
      'title': title,
      'description': description,
      'location': location,
      'jobType': jobType,
      'dueBy': dueBy != null ? Timestamp.fromDate(dueBy!) : null,
      'availableFrom': availableFrom != null ? Timestamp.fromDate(availableFrom!) : null,
      'completion': completed
    };
  }

  itemCard toItemCard() {
    return itemCard(logItem: this);
  }
}
