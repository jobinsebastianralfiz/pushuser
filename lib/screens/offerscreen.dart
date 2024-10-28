import 'package:flutter/material.dart';
import 'package:pushuser/models/offer.dart';

import '../services/database_service.dart';
import '../services/notification_service.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
          onRefresh: () async => setState(() {}),
          child: StreamBuilder<List<Offer>>(
              stream: _databaseService.getActiveOffers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Some Error ${snapshot.error}"),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Offers"),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.length,

                    itemBuilder: (context, index) {
                  final offer = snapshot.data![index];

                  return ListTile(
                    title: Text("${offer.title}"),
                    subtitle: Text("${offer.description}"),
                  );
                });
              })),
    );
  }
}
