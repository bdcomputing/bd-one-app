class RequestStatementDto {
  final String clientId;
  final DateTime startDate;
  final DateTime endDate;
  final String? currencyId;

  RequestStatementDto({
    required this.clientId,
    required this.startDate,
    required this.endDate,
    this.currencyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      if (currencyId != null) 'currencyId': currencyId,
    };
  }
}
