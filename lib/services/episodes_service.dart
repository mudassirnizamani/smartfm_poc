import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/episode.dart';
import 'package:smartfm_poc/services/api.dart';

class EpisodesService {
  static Future<void> createEpisode(
      String title, String audioBookId, File episode) async {
    FormData data = FormData.fromMap({
      'title': title,
      'audioBookId': audioBookId,
      'audioFile': await MultipartFile.fromFile(
        episode.path,
        filename: episode.uri.toString(),
      )
    });

    try {
      await Api.dio.post('/episode', data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  static Future<List<Episode>> fetchEpisodesUsingAudioBookId(
      String audioBookId) async {
    try {
      final res = await Api.dio.get("/episodes/book/$audioBookId");

      if (res.data["episodes"] == null) {
        return [];
      }

      final List<Episode> chapters = res.data["episodes"]
          .map<Episode>((json) => Episode.fromJson(json))
          .toList();

      return chapters;
    } on DioException {
      rethrow;
    }
  }
}
