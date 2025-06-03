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

    for (final city in cities) {
      final docRef = firestore.collection('cities').doc(city['name']);
      batch.set(docRef, city);
    }
    await batch.commit();
    print('Dodano ${cities.length} miast do Firestore');
  }
}
