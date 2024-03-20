import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatService extends ChangeNotifier {
  List<String> catImages = [];
  List<String> favoriteCatImages = [];
  late SharedPreferences _prefs;

  CatService() {
    // 클래스 초기화 메서드 호출
    init();
  }

  void init() async {
    // 비동기로 초기화 메서드를 호출
    await _init();
  }

  Future<void> _init() async {
    // SharedPreferences 초기화
    _prefs = await SharedPreferences.getInstance();
    _loadFavoriteCatImages();
    getRandomCatImages();
  }

  void _loadFavoriteCatImages() {
    List<String> savedImages = _prefs.getStringList('favoriteCatImages') ?? [];
    favoriteCatImages.addAll(savedImages);
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteCatImages.contains(catImage)) {
      favoriteCatImages.remove(catImage);
    } else {
      favoriteCatImages.add(catImage);
    }
    _prefs.setStringList('favoriteCatImages', favoriteCatImages);
    notifyListeners();
  }

  void getRandomCatImages() async {
    String path =
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg";
    var result = await Dio().get(path);
    for (int i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      catImages.add(map['url']);
    }
    notifyListeners();
  }
}
