import 'package:cloud_firestore/cloud_firestore.dart';

class VendorApplicationModel {
  final String applicationId;
  final String jobId;
  final String eventId;
  final String plannerId;
  final String vendorId;
  final String serviceCategory;
  final String proposal;
  final double quotedPrice;
  final bool availability;
  final String status; // applied | shortlisted | accepted | rejected
  final String guest;
  final DateTime createdAt;

  VendorApplicationModel({
    required this.applicationId,
    required this.jobId,
    required this.eventId,
    required this.plannerId,
    required this.vendorId,
    required this.serviceCategory,
    required this.proposal,
    required this.quotedPrice,
    required this.availability,
    required this.status,
    required this.guest,
    required this.createdAt,
  });

  ///  Convert Firestore → Model
  factory VendorApplicationModel.fromMap(
      Map<String, dynamic> map,
      String docId,
      ) {
    return VendorApplicationModel(
      applicationId: docId,
      jobId: map['jobId'] ?? '',
      eventId: map['eventId'] ?? '',
      plannerId: map['plannerId'] ?? '',
      vendorId: map['vendorId'] ?? '',
      serviceCategory: map['serviceCategory'] ?? '',
      proposal: map['proposal'] ?? '',
      quotedPrice: (map['quotedPrice'] ?? 0).toDouble(),
      availability: map['availability'] ?? false,
      status: map['status'] ?? 'applied',
      guest: map['guest'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  ///  Convert Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'eventId': eventId,
      'plannerId': plannerId,
      'vendorId': vendorId,
      'serviceCategory': serviceCategory,
      'proposal': proposal,
      'quotedPrice': quotedPrice,
      'availability': availability,
      'status': status,
      'guest': guest,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
