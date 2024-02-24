import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/episode.dart';
import 'package:smartfm_poc/services/api.dart';

class EpisodesService {
  static Future<void> createEpisode(
      String title, String audioBookId, File episode) async {
    try {
      FormData data = FormData.fromMap({
        'title': title,
        'bookId': audioBookId,
        'episode': await MultipartFile.fromFile(
          episode.path,
          filename: episode.uri.toString(),
        )
      });

      await Api.dio.post(
        '/episodes',
        data: data,
        options: Options(
          receiveTimeout: const Duration(minutes: 2),
        ),
      );
    } on DioException {
      rethrow;
    }
  }

  static Future<List<Episode>> fetchEpisodesUsingAudioBookId(
      String audioBookId) async {
    try {
      final res = await Api.dio.get("/episodes/book/$audioBookId");

      if (res.data["Data"] == null) {
        return [];
      }

      final List<Episode> episodes = res.data["Data"]
          .map<Episode>((json) => Episode.fromJson(json))
          .toList();

      return episodes;
    } on DioException {
      rethrow;
    }
  }
}
