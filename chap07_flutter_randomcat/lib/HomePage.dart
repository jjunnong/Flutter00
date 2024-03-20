import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CatService.dart';
import 'main.dart';

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
              // 앱바의 하트 버튼 onPressed 콜백에서 FavoritePage로 이동합니다.
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/favorite');
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
