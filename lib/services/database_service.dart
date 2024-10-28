import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/offer.dart';

class DatabaseService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Offer>> getActiveOffers() {
    return _firestore
        .collection('offers')
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Offer.fromJosn(doc.data(), documentId: doc.id))
        .toList());
  }

}