import 'dart:io';

import 'package:dio/dio.dart';
import 'package:translators/core/networking/api_constants.dart';
import 'package:translators/core/networking/dio_factory.dart';

class UploadImageDataSource {
  final Dio dio;

  UploadImageDataSource({required this.dio});

  Future<String> uploadImage(
      {required File file,
      required String endpoint,
      required String key}) async {
    FormData formData = FormData.fromMap({
      key: [
        await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last)
      ],
    });
    final response = await dio.patch(
      "${ApiConstants.baseUrl}$endpoint",
      data: formData,
      options: Options(headers: {'token': '${await getToken()}'}),
    );
    return response.data.toString();
  }
}
