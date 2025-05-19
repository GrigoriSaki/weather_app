import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> seedCountryCityData() async {
    final existingCountries = await firestore.collection('countries').get();

    // Check if countries already exist
    // If they do, we don't need to seed them again
    if (existingCountries.docs.isNotEmpty) {
      print('Countries already seeded.');
      return;
    }

    final data = {
      'PL': {
        'name': 'Poland',
        'cities': ['Warsaw', 'Krakow', 'Gdansk', 'Wroclaw', 'Poznan'],
      },
      'DE': {
        'name': 'Germany',
        'cities': ['Berlin', 'Munich', 'Hamburg', 'Cologne', 'Frankfurt'],
      },
      'FR': {
        'name': 'France',
        'cities': ['Paris', 'Lyon', 'Marseille', 'Nice', 'Toulouse'],
      },
      'ES': {
        'name': 'Spain',
        'cities': ['Madrid', 'Barcelona', 'Seville', 'Valencia', 'Malaga'],
      },
      'IT': {
        'name': 'Italy',
        'cities': ['Rome', 'Milan', 'Naples', 'Florence', 'Venice'],
      },
      'UK': {
        'name': 'United Kingdom',
        'cities': [
          'London',
          'Manchester',
          'Birmingham',
          'Glasgow',
          'Liverpool'
        ],
      },
      'US': {
        'name': 'United States',
        'cities': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'],
      },
      'CA': {
        'name': 'Canada',
        'cities': ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
      },
      'JP': {
        'name': 'Japan',
        'cities': ['Tokyo', 'Osaka', 'Kyoto', 'Nagoya', 'Sapporo'],
      },
      'BR': {
        'name': 'Brazil',
        'cities': [
          'São Paulo',
          'Rio de Janeiro',
          'Brasília',
          'Salvador',
          'Fortaleza'
        ],
      },
      'AU': {
        'name': 'Australia',
        'cities': ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide'],
      },
      'IN': {
        'name': 'India',
        'cities': ['Delhi', 'Mumbai', 'Bangalore', 'Chennai', 'Kolkata'],
      },
    };

    // Add country data
    for (final entry in data.entries) {
      final countryCode = entry.key;
      final country = entry.value;

      final countryDoc = firestore.collection('countries').doc(countryCode);

      await countryDoc.set({
        'name': country['name'],
      });

      // Add cities data
      final cities = country['cities'] as List<String>;
      for (final city in cities) {
        await countryDoc.collection('cities').add({
          'name': city,
        });
      }
    }
  }

  Future<List<String>> getCountryNames() async {
    try {
      final snapshot = await firestore.collection('countries').get();

      return snapshot.docs.map((doc) => doc.data()['name'] as String).toList();
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<List<String>> getCityNames(String countryName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('countries')
          .where('name', isEqualTo: countryName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return ["Polonia"];
      }

      final countryId = querySnapshot.docs.first.id;

      final citiesSnapshot = await FirebaseFirestore.instance
          .collection('countries')
          .doc(countryId)
          .collection('cities')
          .get();

      return citiesSnapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();
    } catch (e) {
      throw Exception('Nie udało się pobrać miast: $e');
    }
  }
}
