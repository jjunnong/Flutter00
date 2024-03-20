import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// cat service
class CatService extends ChangeNotifier {
  List<String> catImages = [];
  // 좋아요한 사진
  List<String> favoriteCatImages = [];
  // CatService 생성자
  CatService() {
    // api 호추 함수
    getRandomCatImages();
  }
  // 랜덤 고양이 사진 API 호출 함수
  void getRandomCatImages() async {
    String path =
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg";
    var result = await Dio().get(path);
    for (int i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map);
      print(map['url']);
      // catImages에 이미지 url 추가
      catImages.add(map['url']);
    }

    notifyListeners();
  }

  // 좋아요 기능
  void toggleFavoriteImage(String catImage) {
    if (favoriteCatImages.contains(catImage)) {
      favoriteCatImages.remove(catImage);
    } else {
      favoriteCatImages.add(catImage);
    }
    // 새로고침
    notifyListeners();
  }
}

// HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "랜덤고양이",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.indigo,
            actions: [
              IconButton(
                  onPressed: () {
                    // 아이콘 버튼 눌렀을 때 동작
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
            ],
          ),
          body: GridView.count(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            children: List.generate(
              catService.catImages.length,
              (index) {
                String catImage = catService.catImages[index];
                return GestureDetector(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          catImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Icon(
                          Icons.favorite,
                          color: catService.favoriteCatImages.contains(catImage)
                              ? Colors.red
                              : Colors.transparent,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    // 사진 클릭시 작동
                    catService.toggleFavoriteImage(catImage);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
