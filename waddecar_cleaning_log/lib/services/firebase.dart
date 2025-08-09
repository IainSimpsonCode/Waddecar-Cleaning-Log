// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:waddecar_cleaning_log/classes/LogItem.dart';

// Stream<List<LogItem>> streamLogItems(String jobType, int? completionLevel, bool future) {
//   final now = DateTime.now();

//   Query query = FirebaseFirestore.instance
//     .collection('Logs')
//     .where("jobType", isEqualTo: jobType);

//   if (completionLevel != null) {
//     query = query.where("completion", isEqualTo: completionLevel);
//   }

//   if (future) {
//     query = query.where("availableFrom", isGreaterThan: now);
//   } else {
//     query = query.where("availableFrom", isLessThanOrEqualTo: now);
//   }

//   return query.snapshots().map((snapshot) {
//     return snapshot.docs
//         .map((doc) => LogItem.fromJson(doc.id, doc.data() as Map<String, dynamic>))
//         .toList();
//   });
// }

// Future<void> saveLogItem(LogItem item) async {
//   await FirebaseFirestore.instance
//     .collection('Logs')
//     .add(item.toJson());
// }

// Future<void> deleteDoc(String docID) async {
//   await FirebaseFirestore.instance
//     .collection("Logs")
//     .doc(docID)
//     .delete();
// }

// Future<void> updateDoc(String docID, String field, var value) async {
//   await FirebaseFirestore.instance
//     .collection("Logs")
//     .doc(docID)
//     .update({field: value});
// }

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddecar_cleaning_log/classes/LogItem.dart';

const offlineTesting = true;
const String offlineDataLocation = 'mock_data.json';

List<LogItem> _mockLogItems = [];
bool _mockLoaded = false;

Future<void> _loadMockData() async {
  if (_mockLoaded) return;
  final String jsonString = await rootBundle.loadString(offlineDataLocation);
  final List<dynamic> data = json.decode(jsonString);

  _mockLogItems = data.asMap().entries.map((entry) {
    final i = entry.key;
    final e = entry.value;
    return LogItem.fromJson(
      "mock_$i",
      {
        ...e,
        "dueBy": e["dueBy"] != null ? Timestamp.fromDate(DateTime.parse(e["dueBy"])) : null,
        "availableFrom": e["availableFrom"] != null ? Timestamp.fromDate(DateTime.parse(e["availableFrom"])) : null
      }
    );
  }).toList();

  _mockLoaded = true;
}

/// Get a stream of LogItems
Stream<List<LogItem>> streamLogItems(String jobType, int? completionLevel, bool future) {
  if (offlineTesting) {
    return (() async* {
      await _loadMockData();
      final now = DateTime.now();
      var filtered = _mockLogItems.where((item) => item.jobType == jobType).toList();

      if (completionLevel != null) {
        filtered = filtered.where((item) => item.completed == completionLevel).toList();
      }

      if (future) {
        filtered = filtered.where((item) =>
          item.availableFrom != null && item.availableFrom!.isAfter(now)).toList();
      } else {
        filtered = filtered.where((item) =>
          item.availableFrom == null || item.availableFrom!.isBefore(now) || item.availableFrom!.isAtSameMomentAs(now)).toList();
      }

      yield filtered;
    })();
  }

  // Firestore version
  final now = DateTime.now();
  Query query = FirebaseFirestore.instance
    .collection('Logs')
    .where("jobType", isEqualTo: jobType);

  if (completionLevel != null) {
    query = query.where("completion", isEqualTo: completionLevel);
  }

  if (future) {
    query = query.where("availableFrom", isGreaterThan: now);
  } else {
    query = query.where("availableFrom", isLessThanOrEqualTo: now);
  }

  return query.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => LogItem.fromJson(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  });
}

/// Save a LogItem
Future<void> saveLogItem(LogItem item) async {
  if (offlineTesting) {
    await _loadMockData();
    _mockLogItems.add(item);
    return;
  }

  await FirebaseFirestore.instance
    .collection('Logs')
    .add(item.toJson());
}

/// Delete a LogItem
Future<void> deleteDoc(String docID) async {
  if (offlineTesting) {
    await _loadMockData();
    _mockLogItems.removeWhere((item) => item.docID == docID);
    return;
  }

  await FirebaseFirestore.instance
    .collection("Logs")
    .doc(docID)
    .delete();
}

/// Update a LogItem field
Future<void> updateDoc(String docID, String field, dynamic value) async {
  if (offlineTesting) {
    await _loadMockData();
    final index = _mockLogItems.indexWhere((item) => item.docID == docID);
    if (index != -1) {
      final updatedMap = _mockLogItems[index].toJson();
      updatedMap[field] = value;
      _mockLogItems[index] = LogItem.fromJson(docID, updatedMap);
    }
    return;
  }

  await FirebaseFirestore.instance
    .collection("Logs")
    .doc(docID)
    .update({field: value});
}
