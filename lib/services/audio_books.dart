import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfm_poc/services/api.dart';

class CreateAudioBookResponse {
  final String? id;
  final String? name;
  final String? description;
  final String? genre;

  CreateAudioBookResponse({this.id, this.name, this.description, this.genre});

  factory CreateAudioBookResponse.fromJson(Map<String, dynamic> json) {
    return CreateAudioBookResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      genre: json['genre'],
    );
  }
}

class AudioBookService {
  Future<CreateAudioBookResponse> createAudioBook(
      String name, String description, String genre, File cover) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'genre': genre,
      'cover': await MultipartFile.fromFile(cover.path, filename: 'cover.png')
    });

    try {
      final res = await Api.dio.post('/audiobook', data: formData);

      return CreateAudioBookResponse.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }
}
