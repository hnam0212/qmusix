import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/youtube_model.dart';

class AppRepository {
  AppRepository();

  Future<List<YoutubeModel>> getYoutbeSearch(String searchQuery) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () async {
        final String response =
            await rootBundle.loadString('assets/example_youtube_list.json');
        final data = await json.decode(response);
        final items = data['items'] as List<dynamic>;
        return items.map((e) => YoutubeModel.fromJson(e)).toList();
      },
    );
  }
}
