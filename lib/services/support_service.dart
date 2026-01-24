import 'package:bdoneapp/core/utils/api_client.dart';
import 'package:bdoneapp/core/endpoints.dart';
import 'package:bdoneapp/models/common/paginated_data.dart';
import 'package:bdoneapp/models/common/http_response.dart';
import 'package:bdoneapp/models/common/support_request.dart';

class SupportService {
  final ApiClient _apiClient;
  SupportService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<SupportRequest> createSupportRequest(Map<String, dynamic> payload) async {
    final response = await _apiClient.post(ApiEndpoints.createSupportRequest, data: payload);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SupportRequest.fromJson(response.data['data']);
    }
    
    final errorMessage = response.data?['message'] ?? 'Failed to create support request';
    throw Exception('$errorMessage (Status: ${response.statusCode})');
  }

  Future<PaginatedData<SupportRequest>> fetchSupportRequests({
    String? clientId,
    int page = 1,
    int limit = 10,
    String? keyword,
  }) async {
    final Map<String, dynamic> params = {
      'page': page,
      'limit': limit,
    };
    if (clientId != null && clientId.isNotEmpty) params['clientId'] = clientId;
    if (keyword != null && keyword.isNotEmpty) params['keyword'] = keyword;

    final response = await _apiClient.get(ApiEndpoints.supportRequests, queryParameters: params);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = CustomHttpResponse.fromJson(
        response.data,
        (data) => PaginatedData<SupportRequest>.fromJson(
          data,
          (item) => SupportRequest.fromJson(item as Map<String, dynamic>),
        ),
      );
      return res.data;
    }
    throw Exception('Failed to fetch support requests: ${response.statusCode}');
  }

  Future<SupportRequest> fetchSupportRequestById(String requestId) async {
    final url = '${ApiEndpoints.viewSupportRequest}/$requestId';
    final response = await _apiClient.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SupportRequest.fromJson(response.data['data']);
    }
    throw Exception('Failed to fetch support request: ${response.statusCode}');
  }
}
