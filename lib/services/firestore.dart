import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> loadCitiesFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/data/cities.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    return List<Map<String, dynamic>>.from(jsonList);
  }

  Future<void> seedCities() async {
    final cities = await loadCitiesFromAssets();

    final batch = firestore.batch();
    final snapshot = await firestore.collection('cities').get();

    if (snapshot.docs.isEmpty) {
      {
        for (final city in cities) {
          final docRef = firestore.collection('cities').doc(city['name']);
          batch.set(docRef, city);
        }
        await batch.commit();
        print('Added ${cities.length} cities to Firestore.');
      }
    } else {
      print("Cities already exist in Firestore, skipping seeding.");
    }
  }

  Future<List<Map<String, dynamic>>> getCities() async {
    final snapshot = await firestore.collection('cities').get();
    return snapshot.docs
        // ignore: unnecessary_cast
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
