import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:fludip/net/webClient.dart';
import 'package:fludip/provider/news/newsModel.dart';

///Keeps all news organized in a map
///The key to each is the route by which they were retrieved
///'global' is a special key, its associated with the route "/studip/news"
class NewsProvider extends ChangeNotifier {
  Map<String, List<News>> _newsMap;
  final WebClient _client = WebClient();

  bool initialized() {
    return _newsMap != null;
  }

  bool initializedCourse(String courseID) {
    return _newsMap.containsKey(courseID);
  }

  Future<List<News>> get(String courseID) async {
    _newsMap ??= new Map<String, List<News>>();

    if (!initializedCourse(courseID)) {
      return forceUpdate(courseID);
    }

    return Future<List<News>>.value(_newsMap[courseID]);
  }

  Future<List<News>> forceUpdate(String courseID) async {
    Response res;
    if (courseID == "global") {
      res = await _client.httpGet("/studip/news");
    } else {
      res = await _client.httpGet("/course/$courseID/news");
    }

    List<News> news = <News>[];
    Map<String, dynamic> decoded = jsonDecode(res.body)["collection"];
    decoded.forEach((newsIDUrl, data) {
      news.add(News.fromMap(data));
    });

    _newsMap[courseID] = news;

    notifyListeners();
    return Future<List<News>>.value(_newsMap[courseID]);
  }
}
