import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serve_now/services/tasker_auth.dart';

class TaskerUser {
  Future<List<dynamic>> getTaskerData() async {
    final TaskerAuth taskerAuth = TaskerAuth();
    try {
      final token = await taskerAuth.getToken();
      final url = Uri.parse('https://servenow.com.my/api/get-tasker-details');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body)['data'];
        return data;
      } else {
        throw Exception('Failed to get tasker data');
      }
    } catch (e) {
      throw Exception("Failed to fetch API: $e");
    }
  }

  Future<Map<String, dynamic>> updateTaskerData(
      String id, Map<String, dynamic> updatedData) async {
    final TaskerAuth taskerAuth = TaskerAuth();
    try {
      final token = await taskerAuth.getToken();
      final url = Uri.parse('https://servenow.com.my/api/update-profile-$id');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(updatedData),
      );

      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('No response body received');
      }
    } catch (e) {
      throw Exception('Failed to update tasker data: $e');
    }
  }
}
