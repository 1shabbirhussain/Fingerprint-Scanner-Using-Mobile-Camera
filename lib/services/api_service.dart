// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class ApiService {
//   final String baseUrl;
//   final Dio _dio;

//   ApiService({required this.baseUrl})
//       : _dio = Dio(BaseOptions(
//           baseUrl: baseUrl,
//           connectTimeout: const Duration(seconds: 30),
//           receiveTimeout: const Duration(seconds: 30),
//       )
//         );

//   Future<void> uploadImages(File image1) async {
//     MultipartFile file1 = await MultipartFile.fromFile(image1.path,filename: "image1.png",);
//     // MultipartFile file2 = await MultipartFile.fromFile(image2.path,filename: "image2.png");

//     try {
//       final formData = FormData.fromMap({
//         'file1':file1,
//         // 'file2':file2,
//       });
//       // _dio.options.headers['content-Type'] = 'multipart/form-data';
//       // _dio.options.headers['accept'] = 'application/json';

//       final response = await _dio.post('', data: formData,options: Options());

//       if (response.statusCode == 200) {
//         // Directly access response data, no need for json.decode
//         final responseData = response.data;
//         print(responseData.body);
//         print(responseData);

//         // String status = responseData['status'];
//         // String score = responseData['score'];

//         // print('Verification status: $status');
//         // print('Score of matched templates: $score');

//         // Fluttertoast.showToast(
//         //   msg: "Status: $status, Score: $score",
//         //   toastLength: Toast.LENGTH_LONG,
//         //   gravity: ToastGravity.BOTTOM,
//         // );
//       } else {
//         print('Failed to upload images: ${response.statusCode}');
//         Fluttertoast.showToast(
//           msg: "Failed to verify fingerprints",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//         );
//       }
//     } catch (e) {
//       print('Error uploading images: $e');
//       Fluttertoast.showToast(
//         msg: "Error: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class ImageUploadService {
  final Dio _dio;

  ImageUploadService(this._dio) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("Request: ${options.method} ${options.path}");
          print("Headers: ${options.headers}");
          print("Data: ${options.data}");
          handler.next(options); // Continue
        },
        onResponse: (response, handler) {
          print("Response: ${response.statusCode}");
          print("Data: ${response.data}");
          handler.next(response); // Continue
        },
        onError: (DioError e, handler) {
          print("Error: ${e.response?.statusCode}");
          print("Error data: ${e.response?.data}");
          handler.next(e); // Continue
        },
      ),
    );
  }

  Future<String?> uploadImage(File file, String uploadUrl) async {
    try {
      print(
          "===============================================================================");
      print(file.path);

      if (!file.existsSync() || file.path.isEmpty) {
        return 'File does not exist';
      }

      var data =  FormData.fromMap({
        'file': [
          await MultipartFile.fromFile(file.path, filename: 'abcd.png')
        ],
      });

      Response response = await _dio.request(
        uploadUrl,
        data: data,
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return json.encode(response.data);
      } else {
        print(response.statusMessage);
        return ("Error: ${response.statusMessage}");
      }
    } catch (e) {
      if (e is DioError) {
        return 'Dio error: ${e.message}';
      } else {
        return 'Unexpected error: $e';
      }
    }
  }
}
