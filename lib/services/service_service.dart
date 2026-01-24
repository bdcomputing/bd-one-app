import 'package:bdcomputing/core/utils/api_client.dart';
import 'package:bdcomputing/core/endpoints.dart';
import 'package:bdcomputing/models/common/service.dart';

class ServiceService {
  final ApiClient _apiClient;
  ServiceService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<ServiceModel>> fetchServices() async {
    final response = await _apiClient.get(ApiEndpoints.services);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => ServiceModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch services: ${response.statusCode}');
  }
}
