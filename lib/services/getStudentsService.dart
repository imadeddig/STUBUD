import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.1.11:5000'; // Verify IP!

  Future<List<Map<String, dynamic>>> fetchUsers({
    required String userID,
    Map<String, dynamic>? appliedFilters,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/fetch-students'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userID': userID, 'appliedFilters': appliedFilters ?? {}}),
      ).timeout(const Duration(seconds: 30)); // Add timeout

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception('Failed with status ${response.statusCode}: ${response.body}');
      }
    } on http.ClientException catch (e) {
      print('Connection error: $e');
      throw Exception('Server unreachable. Check network.');
    } on SocketException catch (e) {
      print('Network error: $e');
      throw Exception('No internet connection.');
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      throw Exception('Request timed out.');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to fetch users.');
    }
  }



   // Test method for GET request
  Future<Map<String, dynamic>> fetchTestData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/test-endpoint'), // Testing endpoint
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        print('success !!!!');
        return json.decode(response.body); // Return the response as JSON
      } else {
        throw Exception('Failed with status ${response.statusCode}: ${response.body}');
      }
    } on http.ClientException catch (e) {
      print('Connection error: $e');
      throw Exception('Server unreachable. Check network.');
    } on SocketException catch (e) {
      print('Network error: $e');
      throw Exception('No internet connection.');
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      throw Exception('Request timed out.');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to fetch test data.');
    }
  }
}