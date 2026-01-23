import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bdcomputing/screens/auth/providers.dart';
import 'package:bdcomputing/core/utils/api_client.dart';
import 'package:bdcomputing/services/settings_service.dart';
import 'package:bdcomputing/services/terms_service.dart';
import 'package:bdcomputing/services/invoice_service.dart';
import 'package:bdcomputing/services/payment_service.dart';

/// Global ApiClient provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.client;
});

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final client = ref.watch(unauthenticatedApiClientProvider);
  return SettingsService(apiClient: client);
});

final termsServiceProvider = Provider<TermsService>((ref) {
  final client = ref.watch(unauthenticatedApiClientProvider);
  return TermsService(apiClient: client);
});



final invoiceServiceProvider = Provider<InvoiceService>((ref) {
  final client = ref.watch(apiClientProvider);
  return InvoiceService(apiClient: client);
});

final paymentServiceProvider = Provider<PaymentService>((ref) {
  final client = ref.watch(apiClientProvider);
  return PaymentService(apiClient: client);
});


