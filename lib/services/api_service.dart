import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<void> uploadImages(File image1, File image2) async {
    try {
      final url = Uri.parse('$baseUrl/Verify');
      var request = http.MultipartRequest('POST', url);

      request.files.add(await http.MultipartFile.fromPath('image1', image1.path));
      request.files.add(await http.MultipartFile.fromPath('image2', image2.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var decodedResponse = json.decode(responseData.body);

        String status = decodedResponse['status'];
        String score = decodedResponse['score'];

        // Log the response
        print('Verification status: $status');
        print('Score of matched templates: $score');

        // Show a toast message with the response status
        Fluttertoast.showToast(
          msg: "Status: $status, Score: $score",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        print('Failed to upload images: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: "Failed to verify fingerprints",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print('Error uploading images: $e');
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
