class Statement {
  final String id;
  final String clientId;
  final String statementNumber;
  final DateTime startDate;
  final DateTime endDate;
  final String currencyId;
  final String status; // PENDING, GENERATED, FAILED
  final String? statementLink;
  final DateTime createdAt;
  final DateTime updatedAt;

  Statement({
    required this.id,
    required this.clientId,
    required this.statementNumber,
    required this.startDate,
    required this.endDate,
    required this.currencyId,
    required this.status,
    this.statementLink,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Statement.fromJson(Map<String, dynamic> json) {
    return Statement(
      id: json['_id'] ?? json['id'] ?? '',
      clientId: json['clientId'] ?? '',
      statementNumber: json['statementNumber'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      currencyId: json['currencyId'] ?? '',
      status: json['status'] ?? 'PENDING',
      statementLink: json['statementLink'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clientId': clientId,
      'statementNumber': statementNumber,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'currencyId': currencyId,
      'status': status,
      'statementLink': statementLink,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Statement copyWith({
    String? id,
    String? clientId,
    String? statementNumber,
    DateTime? startDate,
    DateTime? endDate,
    String? currencyId,
    String? status,
    String? statementLink,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Statement(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      statementNumber: statementNumber ?? this.statementNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currencyId: currencyId ?? this.currencyId,
      status: status ?? this.status,
      statementLink: statementLink ?? this.statementLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
