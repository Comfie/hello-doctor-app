class Prescription {
  final int id;
  final int beneficiaryId;
  final String? beneficiaryName;
  final String? notes;
  final String status;
  final DateTime issuedDate;
  final DateTime expiryDate;
  final List<PrescriptionFile>? files;
  final DateTime? createdAt;

  Prescription({
    required this.id,
    required this.beneficiaryId,
    this.beneficiaryName,
    this.notes,
    required this.status,
    required this.issuedDate,
    required this.expiryDate,
    this.files,
    this.createdAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);
  bool get requiresPayment => status == 'PaymentPending';
  bool get isPending => status == 'Pending';
  bool get isApproved => status == 'Approved';
  bool get isRejected => status == 'Rejected';
  bool get isDelivered => status == 'Delivered';

  String get statusColor {
    switch (status) {
      case 'Pending':
      case 'PaymentPending':
        return 'orange';
      case 'Approved':
      case 'FullyDispensed':
      case 'Delivered':
        return 'green';
      case 'Rejected':
      case 'Cancelled':
      case 'Expired':
        return 'red';
      case 'UnderReview':
      case 'OnHold':
        return 'blue';
      default:
        return 'grey';
    }
  }

  String get displayStatus {
    switch (status) {
      case 'PaymentPending':
        return 'Payment Pending';
      case 'UnderReview':
        return 'Under Review';
      case 'OnHold':
        return 'On Hold';
      case 'PartiallyDispensed':
        return 'Partially Dispensed';
      case 'FullyDispensed':
        return 'Fully Dispensed';
      case 'ReadyForPickup':
        return 'Ready for Pickup';
      default:
        return status;
    }
  }

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      beneficiaryId: json['beneficiaryId'],
      beneficiaryName: json['beneficiaryName'],
      notes: json['notes'],
      status: json['status'] ?? 'Pending',
      issuedDate: DateTime.parse(json['issuedDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      files: json['files'] != null
          ? (json['files'] as List)
              .map((file) => PrescriptionFile.fromJson(file))
              .toList()
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beneficiaryId': beneficiaryId,
      'beneficiaryName': beneficiaryName,
      'notes': notes,
      'status': status,
      'issuedDate': issuedDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'files': files?.map((file) => file.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class PrescriptionFile {
  final int id;
  final String fileName;
  final String fileUrl;
  final String fileType;

  PrescriptionFile({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
  });

  bool get isImage =>
      fileType.contains('image') ||
      fileName.toLowerCase().endsWith('.jpg') ||
      fileName.toLowerCase().endsWith('.jpeg') ||
      fileName.toLowerCase().endsWith('.png');

  bool get isPdf =>
      fileType.contains('pdf') || fileName.toLowerCase().endsWith('.pdf');

  factory PrescriptionFile.fromJson(Map<String, dynamic> json) {
    return PrescriptionFile(
      id: json['id'],
      fileName: json['fileName'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileType: json['fileType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'fileType': fileType,
    };
  }
}
